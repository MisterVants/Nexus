//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 29/02/20.
//

import Foundation

//TODO: Review class and implementation
internal class RateLimitedProvider: Provider {
    
//    class PendingRequest {
//        let retry: () -> Void
//        
//        init(retry: @escaping () -> Void) {
//            self.retry = retry
//        }
//    }
//    
//    private let client: DataClient
//    
//    private let appRateLimits: RateLimitHandler
//    private var methodRateLimits: [String : RateLimitHandler] = [:]
//    
//    private(set) var runningRequests: [URL : RequestToken] = [:]
//    private(set) var pendingRequests: [URL : PendingRequest] = [:]
//    
//    init(client: DataClient = .init()) {
//        self.client = client
//        self.appRateLimits = RateLimitHandler()
//    }
//    
//    var hasReachedAppRateLimits: Bool {
//        return appRateLimits.hasReachedLimit
//    }
//    
//    func isRunningRequest(url: URL) -> Bool {
//        return runningRequests[url] != nil
//    }
//    
//    func request<T: Decodable>(url: URL, method: EndpointMethod, completion: @escaping (Result<T, Error>) -> Void) {
//        
//        if isRunningRequest(url: url) {
//            completion(.failure(NexusError.requestAlreadyRunning))
//            return
//        }
//        
//        guard !hasReachedAppRateLimits else {
//            if appRateLimits.hasDefinedRateLimits {
//                completion(.failure(NexusError.rateLimitExceeded))
//            } else {
//                // add pending request
//                if pendingRequests[url] == nil {
//                    let pending = PendingRequest {
//                        self.request(url: url, method: method, completion: completion)
//                    }
//                    pendingRequests[url] = pending
//                } else {
//                    completion(.failure(NexusError.requestAlreadyPending))
//                }
//            }
//            return
//        }
//        
//        if methodRateLimits[method.signature] == nil {
//            methodRateLimits[method.signature] = RateLimitHandler()
//        }
//        
//        guard let methodRateLimits = methodRateLimits[method.signature] else {
//            fatalError("")
//        }
//        
//        guard !methodRateLimits.hasReachedLimit else {
//            if methodRateLimits.hasDefinedRateLimits {
//                completion(.failure(NexusError.rateLimitExceeded))
//            } else {
//                // add pending request
//                if pendingRequests[url] == nil {
//                    let pending = PendingRequest {
//                        self.request(url: url, method: method, completion: completion)
//                    }
//                    pendingRequests[url] = pending
//                } else {
//                    completion(.failure(NexusError.requestAlreadyPending))
//                }
//            }
//            return
//        }
//        
//        appRateLimits.holdToken()
//        methodRateLimits.holdToken()
//        
//        // remove from pending requests
//        if pendingRequests[url] != nil {
//            pendingRequests.removeValue(forKey: url)
//        }
//        
//        // make request if pending not canceled
//        let requestToken = client.request(url: url, method: .get) { (response: ApiResponse<T>) in
//            let rateLimitInfo = RateLimitParser().parseRateLimitHeaders(response.headers)
//            self.appRateLimits.handleDynamicRateLimit(rateLimitInfo.app)
//            methodRateLimits.handleDynamicRateLimit(rateLimitInfo.method)
//            self.runningRequests.removeValue(forKey: url)
//            
//            self.tryRestartPendingRequests()
//            
//            completion(response.result)
//        }
//        runningRequests[url] = requestToken
//    }
//    
//    private func tryRestartPendingRequests() {
//        pendingRequests.forEach { $0.value.retry() }
//    }
}
