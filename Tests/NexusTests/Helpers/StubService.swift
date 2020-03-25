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
        if type == ChampionRotationInfo.self {
            return stubChampionRotationJSON.data(using: .utf8)!
        } else if type == Summoner.self {
            return stubSummonerJSON.data(using: .utf8)!
        }
        fatalError("FATAL: [Test Service] Data for type '\(type.self)' don't exist.")
    }
    
    static func stubModel<T: Decodable>(_ type: T.Type) -> T {
        let data = stubData(type)
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            fatalError("FATAL: [Test Service] Cannot decode data for type \(type.self) - ERROR: \(error)")
        }
    }
    
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
