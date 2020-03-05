//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 02/03/20.
//

protocol APIEndpoint {
    var domain: APIDomain {get}
    var provider: Provider {get}
    init(domain: APIDomain, provider: Provider)
}

protocol RiotLiveEndpoint: APIEndpoint {
    associatedtype Method: APIMethod
    var endpoint: RiotAPI.Endpoint {get}
    init(api: RiotAPI, provider: Provider)
    func request<T: Decodable>(_ method: Method, queryParams: [String: String]?, completion: @escaping (Response<T>) -> Void)
}

extension RiotLiveEndpoint {
    
    init(api: RiotAPI, provider: Provider) {
        self.init(domain: api, provider: provider)
    }
    
    func request<T: Decodable>(_ method: Method, queryParams: [String: String]? = nil, completion: @escaping (Response<T>) -> Void) {
        do {
            var queryParameters = queryParams ?? [:]
            // if should send key in url
//            queryParameters["api_key"] =
            var headers: [String : String]?
            
            let url = try domain.asURL().appendingPathComponent(method.endpointPath(from: try endpoint.asURL()).absoluteString)
            let request = APIRequest(url: url,
                                     queryParameters: queryParameters,
                                     httpHeaders: headers,
                                     method: method)
            print("Request created with url: \(try! request.asURL())")
            provider.perform(request, completion: completion)
        } catch {
            fatalError()
        }
    }
}
