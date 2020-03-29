//
//  URL+Mocks.swift
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
@testable import Nexus

class URLSessionMock: URLSessionProtocol {
    
    var error: Error?
    var responseHeaders: [String : String]?
    var stubData: [URL : Data] = [:]
    var callbacksSuccess = false
    var consumeHeaders = false
    
    private(set) var didReceiveRequest = false
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskHandler) -> URLSessionDataTaskProtocol {
        guard let url = request.url else { fatalError() }
        
        let data = self.stubData[url]
        let response = HTTPURLResponse(url: url,
                                       statusCode: callbacksSuccess ? 200 : 400,
                                       httpVersion: nil,
                                       headerFields: responseHeaders)
        
        if consumeHeaders {
            responseHeaders = nil
        }
        didReceiveRequest = true
        
        return URLSessionDataTaskMock(completion: {
            completionHandler(data, response, self.error)
        })
    }
}

class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    
    private let completion: () -> Void
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
    }
    
    func resume() {
        DispatchQueue.global().async {
            self.completion()
        }
    }
}
