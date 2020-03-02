//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 27/02/20.
//

import Foundation

public enum NexusError: Error {
    // TODO: Namespace errors
    case apiKeyNotFound
    case invalidURL(url: URLConvertible)
    case dataTaskError(Error)
    case dataTaskCancelled
    case noResponse
    case badStatusCode(HTTPStatusCode)
    case responseDataNil
    case jsonDecodeFailed(Error, Data)
}

extension NexusError {
    
    var localizedDescription: String {
        switch self {
        case .noResponse:
            return "No response received from the server"
        default:
            return "no description"
        }
    }
}
