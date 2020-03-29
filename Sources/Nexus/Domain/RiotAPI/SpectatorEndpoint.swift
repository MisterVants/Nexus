//
//  SpectatorEndpoint.swift
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

public protocol SpectatorEndpoint {
    func getActiveGames(bySummonerID encryptedSummonerID: String, completion: @escaping (Response<CurrentGameInfo>) -> Void)
    func getFeaturedGames(completion: @escaping (Response<FeaturedGames>) -> Void)
}

struct SpectatorAPI: APIEndpoint {
    typealias Method = SpectatorMethod
    let domain: APIDomain
    let provider: RateLimitedProvider
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
