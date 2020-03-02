//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 29/02/20.
//

public struct ChampionMastery: Codable {
    
    /// The Champion ID of this mastery's champion.
    let championId: Int
    
    /// The encrypted summoner ID of this mastery's owner.
    let summonerId: String
    
    /// Champion level for specified player and champion combination.
    let championLevel: Int
    
    /// Total number of champion points for this player and champion combination - they are used to determine championLevel.
    let championPoints: Int
    
    /// Number of points earned since current level has been achieved.
    let championPointsSinceLastLevel: Int
    
    /// The number of points needed to achieve next level. Zero if player reached maximum champion level for this champion.
    let championPointsUntilNextLevel: Int
    
    /// The token earned for this champion to levelup.
    let tokensEarned: Int
    
    /// A boolean value indicating if a chest was granted for this champion in current season.
    let isChestGranted: Bool
    
    /// Last time this champion was played by this player - in Unix milliseconds time format.
    let lastPlayTime: Int
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
