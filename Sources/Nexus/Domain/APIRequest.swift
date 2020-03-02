//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 02/03/20.
//

import Foundation

struct APIRequest {
    let baseURL: URL
    let pathURL: URL
    let queryParameters: [String : String]?
    let httpHeaders: [String : String]?
    let method: APIMethod
}

extension APIRequest: URLConvertible {
    func asURL() throws -> URL {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else { throw NexusError.invalidURL(url: baseURL) }
        components.path = pathURL.absoluteString
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
