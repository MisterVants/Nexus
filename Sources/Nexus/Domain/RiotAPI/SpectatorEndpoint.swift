//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 13/03/20.
//

import Foundation

public protocol SpectatorEndpoint {
    func getActiveGames(bySummonerID encryptedSummonerID: String, completion: @escaping (Response<CurrentGameInfo>) -> Void)
    func getFeaturedGames(completion: @escaping (Response<FeaturedGames>) -> Void)
}

struct SpectatorAPI: RiotLiveEndpoint {
    typealias Method = SpectatorMethod
    let domain: APIDomain
    let provider: Provider
    let endpoint: RiotAPI.Endpoint = .spectator
}

extension SpectatorAPI {
    
    enum SpectatorMethod: APIMethod {
        case activeGames(_ encryptedSummonerID: String)
        case featuredGames
        
        var signature: String {
            switch self {
            case .activeGames:      return "activeGames"
            case .featuredGames:    return "featuredGames"
            }
        }
        
        func endpointURL(from baseURL: URL) -> URL {
            switch self {
            case .activeGames(let encryptedSummonerID):
                return baseURL.appendingPathComponents("active-games/by-summoner", encryptedSummonerID)
            case .featuredGames:
                return baseURL.appendingPathComponent("featured-games")
            }
        }
    }
}

extension SpectatorAPI: SpectatorEndpoint {
    
    func getActiveGames(bySummonerID encryptedSummonerID: String, completion: @escaping (Response<CurrentGameInfo>) -> Void) {
        request(.activeGames(encryptedSummonerID), completion: completion)
    }
    
    func getFeaturedGames(completion: @escaping (Response<FeaturedGames>) -> Void) {
        request(.featuredGames, completion: completion)
    }
}
