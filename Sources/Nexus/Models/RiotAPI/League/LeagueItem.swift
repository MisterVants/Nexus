//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 02/03/20.
//

public struct LeagueItem: Codable {
    
    /// The player's summoner name.
    let summonerName: String
    
    /// The division inside a tier, depicted by a roman numeral.
    let rank: String
    
    /// A boolean value that determines whether the player has currently won 3 or more consecutive matches.
    let isOnHotStreak: Bool
    
    /// The number of ranked matches won by the player.
    let wins: Int
    
    /// The number of ranked matches lost by the player.
    let losses: Int
    
    /// The number of league poitns the player has.
    let leaguePoints: Int
    
    /// The promotional mini series, if the player is currently in one.
    let miniSeries: MiniSeries?
    
    /// A boolean value that determines whether the player is new in the league it is in.
    let isFreshBlood: Bool
    
    /// A boolean value that determines whether the player has played 100 matches or more on the same ranked tier.
    let isVeteran: Bool
    
    /// A boolean value that determines whether the player is subject to ranked inactivity.
    let isInactive: Bool
    
    /// The player's encrypted summoner ID.
    let summonerId: String
}

internal extension LeagueItem {
    
    enum CodingKeys: String, CodingKey {
        case summonerName
        case isOnHotStreak = "hotStreak"
        case miniSeries
        case wins
        case isVeteran = "veteran"
        case losses
        case isFreshBlood = "freshBlood"
        case isInactive = "inactive"
        case rank
        case summonerId
        case leaguePoints
    }
}
