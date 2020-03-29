//
//  APIEndpoint.swift
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

protocol APIEndpoint {
    associatedtype Method: APIMethod
    
    var domain: APIDomain {get}
    var provider: RateLimitedProvider {get}
    var endpoint: RiotAPI.Endpoint {get}
    
    init(domain: APIDomain, provider: RateLimitedProvider)
    
    func request<T: Decodable>(_ method: Method, queryParams: [String: String]?, completion: @escaping (Response<T>) -> Void)
}

extension APIEndpoint {
    
    func request<T: Decodable>(_ method: Method, queryParams: [String: String]? = nil, completion: @escaping (Response<T>) -> Void) {
        do {
            var queryParameters = queryParams ?? [:]
            var headers: [String : String] = [:]
            
            // TODO: Improve this part
            switch Nexus.apiKeyPolicy {
            case .includeAsHeaderParameter:
                headers["api_key"] = Nexus.apiKey
            case .includeAsQueryParameter:
                queryParameters["api_key"] = Nexus.apiKey
            }
            
            let url = method.endpointURL(from: try domain.asURL().appendingPathComponent(endpoint))
            let request = APIRequest(method: method,
                                     url: url, cachePolicy: .reloadIgnoringLocalCacheData,
                                     queryParameters: queryParameters,
                                     httpHeaders: headers)
            print("Request created with url: \(try! request.asURL())")
            provider.send(request, completion: completion)
        } catch {
            fatalError()
        }
    }
}
