//
//  ChampionMastery.swift
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

public struct ChampionMastery: Codable {
    
    /// The Champion ID of this mastery's champion.
    public let championId: Int
    
    /// The encrypted summoner ID of this mastery's owner.
    public let summonerId: String
    
    /// Champion level for specified player and champion combination.
    public let championLevel: Int
    
    /// Total number of champion points for this player and champion combination - they are used to determine championLevel.
    public let championPoints: Int
    
    /// Number of points earned since current level has been achieved.
    public let championPointsSinceLastLevel: Int
    
    /// The number of points needed to achieve next level. Zero if player reached maximum champion level for this champion.
    public let championPointsUntilNextLevel: Int
    
    /// The token earned for this champion to levelup.
    public let tokensEarned: Int
    
    /// A boolean value indicating if a chest was granted for this champion in current season.
    public let isChestGranted: Bool
    
    /// Last time this champion was played by this player - in Unix milliseconds time format.
    public let lastPlayTime: Int
}

internal extension ChampionMastery {
    
    enum CodingKeys: String, CodingKey {
        case isChestGranted = "chestGranted"
        case championLevel
        case championPoints
        case championId
        case championPointsUntilNextLevel
        case lastPlayTime
        case tokensEarned
        case championPointsSinceLastLevel
        case summonerId
    }
}
