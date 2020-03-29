//
//  Provider.swift
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

protocol Provider {
    func send<T: Decodable>(_ apiRequest: DataRequest, completion: @escaping (Response<T>) -> Void)
}

class DataProvider: Provider {
    
    static let shared = DataProvider()
    
    func send<T: Decodable>(_ apiRequest: DataRequest, completion: @escaping (Response<T>) -> Void) {
        do {
            let request = try apiRequest.asURLRequest()
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                completion(Response(request: request, data: data, response: response, error: error))
            }.resume()
        } catch {
            completion(Response(error: error))
        }
    }
}
