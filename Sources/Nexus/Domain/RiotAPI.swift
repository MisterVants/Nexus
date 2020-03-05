//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 02/03/20.
//

import Foundation

public struct RiotAPI: APIDomain {
    
    enum Endpoint: String {
        case championMastery    = "/lol/champion-mastery/v4"
        case league             = "/lol/league/v4"
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
    
    private static func hostname(for region: Region) -> String {
        return "\(region.platform).api.riotgames.com"
    }
    
    public let hostname: String
    public let region: Region
    
    var championMastery: ChampionMasteryEndpoint {
        return buildEndpoint(ChampionMasteryAPI.self)
    }
    
    init(region: Region) throws {
        guard Nexus.apiKey != nil else { throw NexusError.apiKeyNotFound }
        self.region = region
        self.hostname = Self.hostname(for: region)
    }
    
    private func buildEndpoint<T>(_ type: T.Type) -> T where T: RiotLiveEndpoint {
        return T(domain: self, provider: Self.rateLimitedProvider(for: self.region))
    }
}

extension RiotAPI.Endpoint: URLConvertible {
    public func asURL() throws -> URL {
        guard let url = URL(string: self.rawValue) else { fatalError() }//throw AFError.invalidURL(url: self) }
        return url
    }
}
