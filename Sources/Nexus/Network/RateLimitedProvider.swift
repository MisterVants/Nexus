//
//  RateLimitedProvider.swift
//
//  Copyright (c) 2020 André Vants
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

final class RateLimitedProvider {
    
    typealias PendingRequest = () -> Void
    typealias URLTaskHandler = (Data?, URLResponse?, Error?) -> Void
    
    var buildRateLimitHandler: () -> RateLimitBucket = RateLimitHandler.init
    
    var appRateLimits: RateLimitBucket
    private(set) var methodRateLimits: [String : RateLimitBucket] = [:]
    
    private(set) var runningRequests: Set<URL> = Set()
    private(set) var pendingRequests: [URL : PendingRequest] = [:]
    private(set) var pendingCallbacks: [URL : [URLTaskHandler]] = [:]
    
    private let session: URLSessionProtocol
    private let queue = DispatchQueue(label: "rate-limit-queue")
    
    init(session: URLSessionProtocol = URLSession(configuration: .ephemeral)) {
        self.session = session
        self.appRateLimits = buildRateLimitHandler()
    }
    
    private func getMethodRateLimits(_ method: APIMethod) -> RateLimitBucket {
        if let bucket = methodRateLimits[method.signature] {
            return bucket
        }
        let bucket = buildRateLimitHandler()
        methodRateLimits[method.signature] = bucket
        return bucket
    }
    
    private func addPendingCallback(_ callback: @escaping URLTaskHandler, for url: URL) {
        if pendingCallbacks[url] == nil {
            pendingCallbacks[url] = []
        }
        pendingCallbacks[url]?.append(callback)
    }
    
    func send<T>(_ apiRequest: APIRequest, completion: @escaping (Response<T>) -> Void) where T : Decodable {
        queue.async { [weak self] in
            do {
                try self?.perform(apiRequest, completion: completion)
            } catch {
                completion(Response<T>(request: nil, data: nil, response: nil, error: error))
            }
        }
    }
    
    func perform<T>(_ apiRequest: APIRequest, completion: @escaping (Response<T>) -> Void) throws where T : Decodable {
        let url = try apiRequest.asURL()
        let urlRequest = try apiRequest.asURLRequest()
        let taskHandler: URLTaskHandler = { [weak self] (data, urlResponse, error) in
            self?.queue.async {
                let response = Response<T>(request: urlRequest, data: data, response: urlResponse, error: error)
                self?.pendingCallbacks[url]?.forEach { $0(data, urlResponse, error) }
                self?.pendingCallbacks[url]?.removeAll()
                self?.pendingRequests.forEach { $0.value() }
                self?.pendingRequests.removeAll()
                self?.runningRequests.remove(url)
                completion(response)
            }
        }
        
        guard !runningRequests.contains(url) else {
            addPendingCallback(taskHandler, for: url)
            return
        }
        
        do {
            try appRateLimits.holdToken()
            do {
                try getMethodRateLimits(apiRequest.method).holdToken()
            } catch {
                appRateLimits.releaseToken()
                throw error
            }
            runningRequests.insert(url)
            session.dataTask(with: urlRequest) { [weak self] (data, urlResponse, error) in
                self?.queue.async {
                    if let httpResponse = urlResponse as? HTTPURLResponse {
                        let rateLimitInfo = RateLimitParser.parseRateLimitHeaders(httpResponse.allHeaderFields)
                        self?.appRateLimits.resolveDynamicLimits(rateLimitInfo.app)
                        self?.getMethodRateLimits(apiRequest.method).resolveDynamicLimits(rateLimitInfo.method)
                    }
                    taskHandler(data, urlResponse, error)
                }
            }.resume()
        } catch NexusError.rateLimitUndefined {
            if pendingRequests[url] == nil {
                pendingRequests[url] = { [weak self] in self?.send(apiRequest, completion: completion) }
            } else {
                addPendingCallback(taskHandler, for: url)
            }
        } catch {
            completion(Response<T>(request: urlRequest, data: nil, response: nil, error: error))
        }
        return
    }
}
