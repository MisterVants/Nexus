//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 02/03/20.
//

import Foundation

struct APIRequest {
    let url: URL
    let queryParameters: [String : String]?
    let httpHeaders: [String : String]?
    let method: APIMethod
    
    init(url: URL, queryParameters: [String : String]? = nil, httpHeaders: [String : String]? = nil, method: APIMethod) {
        self.url = url
        self.queryParameters = queryParameters
        self.httpHeaders = httpHeaders
        self.method = method
    }
}

extension APIRequest: URLConvertible {
    func asURL() throws -> URL {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { throw NexusError.invalidURL(url: url) }
        components.queryItems = queryParameters?.map { URLQueryItem(name: $0, value: $1) }
        return try components.asURL()
    }
}

extension APIRequest: URLRequestConvertible {
    // TODO: set cache policy for API and DataDragon, set body for tournament methods
    func asURLRequest() throws -> URLRequest {
        do {
            let url = try self.asURL()
            var request = URLRequest(url: url)
            request.httpMethod = method.httpMethod.rawValue
            httpHeaders?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
            return request
        } catch {
            throw error
        }
    }
}
