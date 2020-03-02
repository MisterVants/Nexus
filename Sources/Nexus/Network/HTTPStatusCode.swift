//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 27/02/20.
//

import Foundation

public enum HTTPStatusCode: Int {

    enum Category {
        case informational
        case success
        case redirection
        case clientError
        case serverError
        case undefined
    }

    case undefined              = -1
    case ok                     = 200
    
    case badRequest             = 400
    case unauthorized           = 401
    case forbidden              = 403
    case dataNotFound           = 404
    case methodNotAllowed       = 405
    case unsupportedMediaType   = 415
    case unprocessableEntity    = 422
    case rateLimitExceeded      = 429
    
    case internalError          = 500
    case badGateway             = 502
    case serviceUnavailable     = 503
    case gatewayTimeout         = 504
}

extension HTTPStatusCode {
    
    init(code: Int) {
        guard let statusCode = HTTPStatusCode(rawValue: code) else { self = .undefined; return }
        self = statusCode
    }
    
    var category: HTTPStatusCode.Category {
        switch self.rawValue {
        case 100..<200:
            return .informational
        case 200..<300:
            return .success
        case 300..<400:
            return .redirection
        case 400..<500:
            return .clientError
        case 500..<600:
            return .serverError
        default:
            return .undefined
        }
    }
    
    static func isSuccess(_ statusCode: Int) -> Bool {
        return (200..<300) ~= statusCode
    }
}
