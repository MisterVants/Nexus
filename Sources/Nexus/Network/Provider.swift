//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 27/02/20.
//

protocol Provider {
    func perform<T: Decodable>(_ apiRequest: APIRequest, completion: @escaping (Response<T>) -> Void)
}

// TODO: Implement networking
extension Provider {
    func perform<T: Decodable>(_ apiRequest: APIRequest, completion: @escaping (Response<T>) -> Void) {
        print("requesting...")
        completion(Response(request: try! apiRequest.asURLRequest(), data: nil, response: nil, error: nil))
    }
}
