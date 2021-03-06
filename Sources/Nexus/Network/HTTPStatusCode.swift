//
//  HTTPStatusCode.swift
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
