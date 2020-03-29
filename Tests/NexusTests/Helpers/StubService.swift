//
//  StubService.swift
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
@testable import Nexus

final class StubService {
    
    static func stubData<T>(_ type: T.Type) -> Data {
        switch type {
        case is Realm.Type:                 return stubRealmJSON.data(using: .utf8)!
        case is ChampionRotationInfo.Type:  return stubChampionRotationJSON.data(using: .utf8)!
        case is Summoner.Type:              return stubSummonerJSON.data(using: .utf8)!
        default:
            fatalError("FATAL: [Test Service] Data for type '\(type.self)' don't exist.")
        }        
    }
    
    static func stubModel<T: Decodable>(_ type: T.Type) -> T {
        let data = stubData(type)
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            fatalError("FATAL: [Test Service] Cannot decode data for type \(type.self) - ERROR: \(error)")
        }
    }
    
    private static let stubRealmJSON = """
    {
        "n": {
            "item": "10.6.1",
            "rune": "7.23.1",
            "mastery": "7.23.1",
            "summoner": "10.6.1",
            "champion": "10.6.1",
            "profileicon": "10.6.1",
            "map": "10.6.1",
            "language": "10.6.1",
            "sticker": "10.6.1"
        },
        "v": "10.6.1",
        "l": "en_US",
        "cdn": "https://ddragon.leagueoflegends.com/cdn",
        "dd": "10.6.1",
        "lg": "10.6.1",
        "css": "10.6.1",
        "profileiconmax": 28,
        "store": null
    }
    """
    
    private static let stubChampionRotationJSON = """
    {
        "freeChampionIds": [
            1,
            2
        ],
        "freeChampionIdsForNewPlayers": [
            18,
            81
        ],
        "maxNewPlayerLevel": 10
    }
    """
    
    private static let stubSummonerJSON = """
    {
        "id": "pr7WV69fDy_U1RU775UNe6PB6aTdjk-6X1_VPT9JHDc2mw",
        "accountId": "Op-XTmSopeK_7TMcnp8lcBrFWW1zCeS9sSakjjs_8UqEWrw",
        "puuid": "_m5gRorSozgh0AgPPyUnqLgVC4fnNvmoG992wzhnfUABdrHCg1h56py7yceRnmeZq5u7Jsx1w1wICw",
        "name": "Mister Vants",
        "profileIconId": 3602,
        "revisionDate": 1584983744000,
        "summonerLevel": 208
    }
    """
}
