//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 13/03/20.
//

import Foundation

public protocol ChampionRotationEndpoint {
    func getChampionRotation(completion: @escaping (Response<ChampionRotationInfo>) -> ())
}

struct ChampionRotationAPI: RiotLiveEndpoint {
    typealias Method = ChampionRotationMethod
    let domain: APIDomain
    let provider: Provider
    let endpoint: RiotAPI.Endpoint = .championRotation
}

extension ChampionRotationAPI: ChampionRotationEndpoint {
    
    enum ChampionRotationMethod: APIMethod {
        case championRotation
        
        var signature: String { "championRotation" }
        
        func endpointURL(from baseURL: URL) -> URL {
            return baseURL.appendingPathComponent("champion-rotations")
        }
    }
    
    func getChampionRotation(completion: @escaping (Response<ChampionRotationInfo>) -> ()) {
        request(.championRotation, completion: completion)
    }
}
