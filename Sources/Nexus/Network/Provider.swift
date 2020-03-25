//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 27/02/20.
//

protocol Provider {
    func send<T: Decodable>(_ apiRequest: APIRequest, completion: @escaping (Response<T>) -> Void)
}

// TODO: Implement networking
extension Provider {
    func send<T: Decodable>(_ apiRequest: APIRequest, completion: @escaping (Response<T>) -> Void) {
        completion(Response(request: try! apiRequest.asURLRequest(), data: nil, response: nil, error: nil))
    }
}

import Foundation

class SimpleProvider: Provider {
    
    func send<T>(_ apiRequest: APIRequest, completion: @escaping (Response<T>) -> Void) where T : Decodable {
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
