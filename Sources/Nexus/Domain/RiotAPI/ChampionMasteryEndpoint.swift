//
//  ChampionMasteryEndpoint.swift
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

public protocol ChampionMasteryEndpoint {
    func getMasteries(bySummoner encryptedSummonerID: String, completion: @escaping (Response<[ChampionMastery]>) -> Void)
    func getMasteries(bySummoner encryptedSummonerID: String, byChampion championID: Int, completion: @escaping (Response<ChampionMastery>) -> Void)
    func getScore(bySummoner encryptedSummonerID: String, completion: @escaping (Response<Int>) -> Void)
}

struct ChampionMasteryAPI: APIEndpoint {
    typealias Method = ChampionMasteryMethod
    let domain: APIDomain
    let provider: RateLimitedProvider
    let endpoint: RiotAPI.Endpoint = .championMastery
}

extension ChampionMasteryAPI {
    
    enum ChampionMasteryMethod: APIMethod {
        case masteryBySummoner(_ summonerID: String)
        case masteryBySummonerByChampion(_ summonerID: String, _ championID: Int)
        case masteryScoreBySummoner(_ summonerID: String)
        
        var signature: String {
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
