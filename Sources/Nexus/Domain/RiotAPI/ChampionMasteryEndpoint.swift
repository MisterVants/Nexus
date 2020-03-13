//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 29/02/20.
//

import Foundation

public protocol ChampionMasteryEndpoint {
    func getMasteries(bySummoner encryptedSummonerID: String, completion: @escaping (Response<[ChampionMastery]>) -> Void)
    func getMasteries(bySummoner encryptedSummonerID: String, byChampion championID: Int, completion: @escaping (Response<ChampionMastery>) -> Void)
    func getScore(bySummoner encryptedSummonerID: String, completion: @escaping (Response<Int>) -> Void)
}

struct ChampionMasteryAPI: RiotLiveEndpoint {
    typealias Method = ChampionMasteryMethod
    let domain: APIDomain
    let provider: Provider
    let endpoint: RiotAPI.Endpoint = .championMastery
}

extension ChampionMasteryAPI {
    
    enum ChampionMasteryMethod: APIMethod {
        case masteryBySummoner(_ summonerID: String)
        case masteryBySummonerByChampion(_ summonerID: String, _ championID: Int)
        case masteryScoreBySummoner(_ summonerID: String)
        
        var methodSignature: String {
            switch self {
            case .masteryBySummoner:            return "masteryBySummoner"
            case .masteryBySummonerByChampion:  return "masteryBySummonerByChampion"
            case .masteryScoreBySummoner:       return "masteryScoreBySummoner"
            }
        }
        
        func endpointURL(from baseURL: URL) -> URL {
            switch self {
            case .masteryBySummoner(let summonerID):
                return baseURL.appendingPathComponents("champion-masteries/by-summoner", summonerID)
            case .masteryBySummonerByChampion(let summonerID, let championID):
                return baseURL.appendingPathComponents("champion-masteries/by-summoner", summonerID, "by-champion", "\(championID)")
            case .masteryScoreBySummoner(let summonerID):
                return baseURL.appendingPathComponents("scores/by-summoner", summonerID)
            }
        }
    }
}

extension ChampionMasteryAPI: ChampionMasteryEndpoint {
    
    func getMasteries(bySummoner encryptedSummonerID: String, completion: @escaping (Response<[ChampionMastery]>) -> Void) {
        request(.masteryBySummoner(encryptedSummonerID), completion: completion)
    }

    func getMasteries(bySummoner encryptedSummonerID: String, byChampion championID: Int, completion: @escaping (Response<ChampionMastery>) -> Void) {
        request(.masteryBySummonerByChampion(encryptedSummonerID, championID), completion: completion)
    }

    func getScore(bySummoner encryptedSummonerID: String, completion: @escaping (Response<Int>) -> Void) {
        request(.masteryScoreBySummoner(encryptedSummonerID), completion: completion)
    }
}
