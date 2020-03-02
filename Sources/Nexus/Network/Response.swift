//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 27/02/20.
//

import Foundation

typealias NetworkError = NexusError

public struct Response<T: Decodable> {
    
    public let result: Result<T, Error>
    public let data: Data?
    public let request: URLRequest?
    public let httpResponse: HTTPURLResponse?
    public var value: T? { return result.success }
    public var error: Error? { return result.failure }
    
    init(request: URLRequest? = nil, data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        self.data = data
        self.request = request
        self.httpResponse = response as? HTTPURLResponse
        self.result = Self.validate(data, response, error).flatMap { data -> Result<T, Error> in
            if let rawData = data as? T {
                return .success(rawData)
            }
            return Self.decode(data)
        }
    }
}

extension Response {
    
    private static func validate(_ data: Data?, _ urlResponse: URLResponse?, _ error: Error?) -> Result<Data, Error> {
        if let error = error {
            if (error as NSError).code == NSURLErrorCancelled {
                return .failure(NetworkError.dataTaskCancelled)
            }
            return .failure(NetworkError.dataTaskError(error))
        }
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            return .failure(NetworkError.noResponse)
        }
        guard HTTPStatusCode.isSuccess(httpResponse.statusCode) else {
            return .failure(NetworkError.badStatusCode(HTTPStatusCode(code: httpResponse.statusCode)))
        }
        guard let validData = data else {
            return .failure(NetworkError.responseDataNil)
        }
        return .success(validData)
    }
    
    private static func decode<T: Decodable>(_ data: Data) -> Result<T, Error> {
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
        } catch let jsonError {
            return .failure(NetworkError.jsonDecodeFailed(jsonError, data))
        }
    }
}
