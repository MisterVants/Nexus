//
//  LeagueEndpoint.swift
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

public protocol LeagueEndpoint {
    func getChallengerLeagues(byQueue queue: RankedQueue, completion: @escaping (Response<LeagueList>) -> Void)
    func getGrandmasterLeagues(byQueue queue: RankedQueue, completion: @escaping (Response<LeagueList>) -> Void)
    func getMasterLeagues(byQueue queue: RankedQueue, completion: @escaping (Response<LeagueList>) -> Void)
    func getLeague(byID leagueID: String, completion: @escaping (Response<LeagueList>) -> Void) // Consistently looking up league ids that don't exist will result in a blacklist.
    func getEntries(queue: RankedQueue, tier: RankedTier, division: RankedDivision, page: Int, completion: @escaping (Response<[LeagueEntry]>) -> Void)
    func getEntries(bySummoner encryptedSummonerID: String, completion: @escaping (Response<[LeagueEntry]>) -> Void)
}

struct LeagueAPI: APIEndpoint {
    typealias Method = LeagueMethod
    let domain: APIDomain
    let provider: RateLimitedProvider
    let endpoint: RiotAPI.Endpoint = .league
}

extension LeagueAPI {
    
    enum LeagueMethod: APIMethod {
        case challengerLeagues(_ queue: RankedQueue)
        case grandmasterLeagues(_ queue: RankedQueue)
        case masterLeagues(_ queue: RankedQueue)
        case league(_ leagueID: String)
        case entries(_ queue: RankedQueue, _ tier: RankedTier, _ division: RankedDivision)
        case entriesBySummoner(_ summonerID: String)
        
        var signature: String {
            switch self {
            case .challengerLeagues:    return "challengerLeagues"
            case .grandmasterLeagues:   return "grandmasterLeagues"
            case .masterLeagues:        return "masterLeagues"
            case .league:               return "league"
            case .entries:              return "entries"
            case .entriesBySummoner:    return "entriesBySummoner"
            }
        }
        
        func endpointURL(from baseURL: URL) -> URL {
            switch self {
            case .challengerLeagues(let queue):
                return baseURL.appendingPathComponents("challengerleagues/by-queue", queue.rawValue)
            case .grandmasterLeagues(let queue):
                return baseURL.appendingPathComponents("grandmasterleagues/by-queue", queue.rawValue)
            case .masterLeagues(let queue):
                return baseURL.appendingPathComponents("masterleagues/by-queue", queue.rawValue)
            case .league(let leagueID):
                return baseURL.appendingPathComponents("leagues", leagueID)
            case .entries(let queue, let tier, let division):
                return baseURL.appendingPathComponents("entries", queue.rawValue, tier.rawValue, division.rawValue)
            case .entriesBySummoner(let summonerID):
                return baseURL.appendingPathComponents("entries/by-summoner", summonerID)
            }
        }
    }
}

extension LeagueAPI: LeagueEndpoint {
    
    func getChallengerLeagues(byQueue queue: RankedQueue, completion: @escaping (Response<LeagueList>) -> Void) {
        request(.challengerLeagues(queue), completion: completion)
    }
    
    func getGrandmasterLeagues(byQueue queue: RankedQueue, completion: @escaping (Response<LeagueList>) -> Void) {
        request(.grandmasterLeagues(queue), completion: completion)
    }
    
    func getMasterLeagues(byQueue queue: RankedQueue, completion: @escaping (Response<LeagueList>) -> Void) {
        request(.masterLeagues(queue), completion: completion)
    }
    
    func getLeague(byID leagueID: String, completion: @escaping (Response<LeagueList>) -> Void) {
        request(.league(leagueID), completion: completion)
    }
    
    func getEntries(queue: RankedQueue, tier: RankedTier, division: RankedDivision, page: Int, completion: @escaping (Response<[LeagueEntry]>) -> Void) {
        // TODO: if page < 1 = error
        request(.entries(queue, tier, division), completion: completion)
    }
    
    func getEntries(bySummoner encryptedSummonerID: String, completion: @escaping (Response<[LeagueEntry]>) -> Void) {
        request(.entriesBySummoner(encryptedSummonerID), completion: completion)
    }
}
