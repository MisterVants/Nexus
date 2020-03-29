//
//  Response.swift
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
