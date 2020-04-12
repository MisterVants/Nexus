//
//  LeagueEntry.swift
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

public struct LeagueEntry: Codable {
    
    /// The player's summoner name.
    public let summonerName: String
    
    /// The ranked queue type for this league entry.
    public let queueType: String
    
    /// The player's ranked tier.
    public let tier: String
    
    /// The division inside a tier, depicted by a roman numeral.
    public let rank: String
    
    /// A boolean value that determines whether the player has currently won 3 or more consecutive matches.
    public let isOnHotStreak: Bool
    
    /// The number of ranked matches won by the player.
    public let wins: Int
    
    /// The number of ranked matches lost by the player.
    public let losses: Int
    
    /// The number of league poitns the player has.
    public let leaguePoints: Int
    
    /// The promotional mini series, if the player is currently in one.
    public let miniSeries: MiniSeries?
    
    /// A boolean value that determines whether the player is new in the league it is in.
    public let isFreshBlood: Bool
    
    /// A boolean value that determines whether the player has played 100 matches or more on the same ranked tier.
    public let isVeteran: Bool
    
    /// A boolean value that determines whether the player is subject to ranked inactivity.
    public let isInactive: Bool
    
    /// The UUID of the league this entry belongs to.
    public let leagueId: String
    
    /// The player's encrypted summoner ID.
    public let summonerId: String
}

internal extension LeagueEntry {

    enum CodingKeys: String, CodingKey {
        case queueType
        case summonerName
        case isOnHotStreak = "hotStreak"
        case miniSeries
        case wins
        case isVeteran = "veteran"
        case losses
        case rank
        case leagueId
        case isInactive = "inactive"
        case isFreshBlood = "freshBlood"
        case tier
        case summonerId
        case leaguePoints
    }
}
