//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 02/03/20.
//

import Foundation

protocol APIMethod {
    var httpMethod: HTTPMethod {get}
    var methodSignature: String {get}
    func endpointPath(from baseURL: URL) -> URL
}

extension APIMethod {
    var httpMethod: HTTPMethod { return .get }
}
