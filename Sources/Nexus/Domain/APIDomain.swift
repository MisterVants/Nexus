//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 02/03/20.
//

import Foundation

public protocol APIDomain: URLConvertible {
    var urlScheme: String {get}
    var hostname: String {get}
}

extension APIDomain {
    
    public func asURL() throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = urlScheme
        urlComponents.host = hostname
        return try urlComponents.asURL()
    }
}
