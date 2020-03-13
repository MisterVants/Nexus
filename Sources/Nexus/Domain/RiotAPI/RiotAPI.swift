//
//  RiotAPI.swift
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

public struct RiotAPI: APIDomain {
    
    enum Endpoint: String {
        case championMastery    = "/lol/champion-mastery/v4"
//        case championRotation   = ""
        case league             = "/lol/league/v4"
//        case match              = ""
        case spectator          = "/lol/spectator/v4"
        case summoner           = "/lol/summoner/v4"
    }
    
    private static var regionalProviders: [Region : RateLimitedProvider] = [:]
    private static func rateLimitedProvider(for region: Region) -> RateLimitedProvider {
        guard let provider = regionalProviders[region] else {
            let newProvider = RateLimitedProvider()
            regionalProviders[region] = newProvider
            return newProvider
        }
        return provider
    }
    
    public let region: Region
    
    public var championMastery: ChampionMasteryEndpoint {
        buildEndpoint(ChampionMasteryAPI.self)
    }
    
    public var league: LeagueEndpoint {
        buildEndpoint(LeagueAPI.self)
    }
    
    public var spectator: SpectatorEndpoint {
        buildEndpoint(SpectatorAPI.self)
    }
    
    public var summoner: SummonerEndpoint {
        buildEndpoint(SummonerAPI.self)
    }
    
    init(region: Region) throws {
        guard Nexus.apiKey != nil else { throw NexusError.apiKeyNotFound }
        self.region = region
    }
    
    private func buildEndpoint<T>(_ type: T.Type) -> T where T: RiotLiveEndpoint {
        return T(domain: self, provider: SimpleProvider())// FIXME: Self.rateLimitedProvider(for: self.region))
    }
}

extension RiotAPI.Endpoint: URLConvertible {
    public func asURL() throws -> URL {
        guard let url = URL(string: self.rawValue) else { fatalError() }//throw AFError.invalidURL(url: self) }
        return url
    }
}
