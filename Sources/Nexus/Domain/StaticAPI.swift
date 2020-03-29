//
//  StaticAPI.swift
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

public struct StaticAPI: APIDomain {
    
    enum Asset: String, APIResource {
        case seasons
        case queues
        case maps
        case gameModes
        case gameTypes
        
        func endpointURL(from baseURL: URL) -> URL {
            return baseURL.appendingPathComponents("docs", "lol", self.rawValue).json()
        }
    }
    
    let provider: Provider
    
    init(provider: Provider = DataProvider()) {
        self.provider = provider
    }
    
    public func getSeasons(completion: @escaping (Response<[Season]>) -> Void) {
        get(.seasons, completion: completion)
    }
    
    public func getQueues(completion: @escaping (Response<[Queue]>) -> Void) {
        get(.queues, completion: completion)
    }
    
    public func getMaps(completion: @escaping (Response<[Map]>) -> Void) {
        get(.maps ,completion: completion)
    }
    
    public func getGameModes(completion: @escaping (Response<[GameMode]>) -> Void) {
        get(.gameModes ,completion: completion)
    }
    
    public func getGameTypes(completion: @escaping (Response<[GameType]>) -> Void) {
        get(.gameTypes ,completion: completion)
    }
    
    private func get<T: Decodable>(_ resource: Asset, completion: @escaping (Response<T>) -> Void) {
        request(resource, completion: completion)
    }
    
    private func request<T: Decodable>(_ resource: APIResource, completion: @escaping (Response<T>) -> Void) {
        do {
            let url = resource.endpointURL(from: try self.asURL())
            let request = DataRequest(resource: resource, url: url, cachePolicy: .useProtocolCachePolicy)
            provider.send(request, completion: completion)
        } catch {
            completion(Response(error: error))
        }
    }
}
