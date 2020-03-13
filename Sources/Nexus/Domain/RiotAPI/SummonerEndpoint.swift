//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 12/03/20.
//

import Foundation

public protocol SummonerEndpoint {
    func getSummoner(byEncryptedAccountID encryptedAccountID: String, completion: @escaping (Response<Summoner>) -> Void)
    func getSummoner(byName summonerName: String, completion: @escaping (Response<Summoner>) -> Void)
    func getSummoner(byPUUID puuid: String, completion: @escaping (Response<Summoner>) -> Void)
    func getSummoner(byEncryptedSummonerID encryptedSummonerID: String, completion: @escaping (Response<Summoner>) -> Void)
}

struct SummonerAPI: RiotLiveEndpoint {
    typealias Method = SummonerMethod
    let domain: APIDomain
    let provider: Provider
    let endpoint: RiotAPI.Endpoint = .summoner
}

extension SummonerAPI {
    
    enum SummonerMethod: APIMethod {
        case summonerByAccount(_ encryptedAccountID: String)
        case summonerByName(_ name: String)
        case summonerByPUUID(_ puuid: String)
        case summonerByID(_ encryptedSummonerID: String)
        
        var methodSignature: String {
            switch self {
            case .summonerByAccount:    return "summonerByAccount"
            case .summonerByName:       return "summonerByName"
            case .summonerByPUUID:      return "summonerByPUUID"
            case .summonerByID:         return "summonerByID"
            }
        }
        
        func endpointURL(from baseURL: URL) -> URL {
            switch self {
            case .summonerByAccount(let encryptedAccountID):
                return baseURL.appendingPathComponents("summoners/by-account", encryptedAccountID)
            case .summonerByName(let name):
                print("URL PATH: \(baseURL.appendingPathComponents("summoners/by-name", name))")
                return baseURL.appendingPathComponents("summoners/by-name", name)
            case .summonerByPUUID(let puuid):
                return baseURL.appendingPathComponents("summoners/by-puuid", puuid)
            case .summonerByID(let encryptedSummonerID):
                return baseURL.appendingPathComponents("summoners", encryptedSummonerID)
            }
        }
    }
}

extension SummonerAPI: SummonerEndpoint {
    
    func getSummoner(byEncryptedAccountID encryptedAccountID: String, completion: @escaping (Response<Summoner>) -> Void) {
        request(.summonerByAccount(encryptedAccountID), completion: completion)
    }
    
    func getSummoner(byName summonerName: String, completion: @escaping (Response<Summoner>) -> Void) {
        request(.summonerByName(summonerName), completion: completion)
    }
    
    func getSummoner(byPUUID puuid: String, completion: @escaping (Response<Summoner>) -> Void) {
        request(.summonerByPUUID(puuid), completion: completion)
    }
    
    func getSummoner(byEncryptedSummonerID encryptedSummonerID: String, completion: @escaping (Response<Summoner>) -> Void) {
        request(.summonerByID(encryptedSummonerID), completion: completion)
    }
}
