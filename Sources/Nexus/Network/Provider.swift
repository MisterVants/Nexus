//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 27/02/20.
//

import Foundation

protocol Provider {
    func send<T: Decodable>(_ apiRequest: APIRequest, completion: @escaping (Response<T>) -> Void)
}

class DataProvider: Provider {
    
    static let shared = DataProvider()
    
    func send<T: Decodable>(_ apiRequest: APIRequest, completion: @escaping (Response<T>) -> Void) {
        do {
            let request = try apiRequest.asURLRequest()
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                completion(Response(request: request, data: data, response: response, error: error))
            }.resume()
        } catch {
            fatalError()
        }
    }
}
