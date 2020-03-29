//
//  SummonerEndpoint.swift
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

public protocol SummonerEndpoint {
    func getSummoner(byEncryptedAccountID encryptedAccountID: String, completion: @escaping (Response<Summoner>) -> Void)
    func getSummoner(byName summonerName: String, completion: @escaping (Response<Summoner>) -> Void)
    func getSummoner(byPUUID puuid: String, completion: @escaping (Response<Summoner>) -> Void)
    func getSummoner(byEncryptedSummonerID encryptedSummonerID: String, completion: @escaping (Response<Summoner>) -> Void)
}

struct SummonerAPI: APIEndpoint {
    typealias Method = SummonerMethod
    let domain: APIDomain
    let provider: RateLimitedProvider
    let endpoint: RiotAPI.Endpoint = .summoner
}

extension SummonerAPI {
    
    enum SummonerMethod: APIMethod {
        case summonerByAccount(_ encryptedAccountID: String)
        case summonerByName(_ name: String)
        case summonerByPUUID(_ puuid: String)
        case summonerByID(_ encryptedSummonerID: String)
        
        var signature: String {
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
