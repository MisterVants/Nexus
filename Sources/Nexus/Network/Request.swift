//
//  Request.swift
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

protocol Request: URLConvertible, URLRequestConvertible {
    var url             : URL {get}
    var cachePolicy     : URLRequest.CachePolicy {get}
    var queryParameters : [String : String]? {get}
    var httpHeaders     : [String : String]? {get}
    var resource        : APIResource {get}
}

extension Request {
    
    func asURL() throws -> URL {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { throw NexusError.invalidURL(url: url) }
        components.queryItems = queryParameters?.map { URLQueryItem(name: $0, value: $1) }
        return try components.asURL()
    }
    
    func asURLRequest() throws -> URLRequest {
        do {
            let url             = try self.asURL()
            var request         = URLRequest(url: url)
            request.httpMethod  = resource.httpMethod.rawValue
            request.cachePolicy = cachePolicy
            httpHeaders?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
            return request
        } catch {
            throw error
        }
    }
}

struct DataRequest: Request {
    let resource                : APIResource
    let url                     : URL
    let cachePolicy             : URLRequest.CachePolicy
    let queryParameters         : [String : String]?
    let httpHeaders             : [String : String]?
    
    init(resource               : APIResource,
         url                    : URL,
         cachePolicy            : URLRequest.CachePolicy,
         queryParameters        : [String : String]? = nil,
         httpHeaders            : [String : String]? = nil) {
        
        self.url                = url
        self.cachePolicy        = cachePolicy
        self.queryParameters    = queryParameters
        self.httpHeaders        = httpHeaders
        self.resource           = resource
    }
}

struct APIRequest: Request {
    let method                  : APIMethod
    let url                     : URL
    let cachePolicy             : URLRequest.CachePolicy
    let queryParameters         : [String : String]?
    let httpHeaders             : [String : String]?
    var resource                : APIResource { method }
    
    init(method                 : APIMethod,
         url                    : URL,
         cachePolicy            : URLRequest.CachePolicy,
         queryParameters        : [String : String]? = nil,
         httpHeaders            : [String : String]? = nil) {
        
        self.url                = url
        self.cachePolicy        = cachePolicy
        self.queryParameters    = queryParameters
        self.httpHeaders        = httpHeaders
        self.method             = method
    }
}
