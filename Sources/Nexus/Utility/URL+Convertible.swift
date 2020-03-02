//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 02/03/20.
//

import Foundation

typealias URLError = NexusError

public protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

public protocol URLConvertible {
    func asURL() throws -> URL
}

extension URL: URLConvertible {
    public func asURL() throws -> URL { return self }
}

extension URLComponents: URLConvertible {
    public func asURL() throws -> URL {
        guard let url = self.url else { throw URLError.invalidURL(url: self) }
        return url
    }
}
