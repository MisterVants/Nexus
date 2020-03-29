//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 13/03/20.
//

public struct FeaturedGameParticipant: Codable {
    
    /// The summoner name of this participant.
    let summonerName: String
    
    /// The ID of the profile icon used by this participant.
    let profileIconID: Int
    
    /// A boolean value indicating whether or not this participant is a bot.
    let isBot: Bool
    
    /// The team ID of this participant, indicating the participant's team.
    let teamID: Int
    
    /// The ID of the champion played by this participant.
    let championID: Int
    
    /// The ID of the first summoner spell used by this participant.
    let summonerSpellOneID: Int
    
    /// The ID of the second summoner spell used by this participant.
    let summonerSpellTwoID: Int
}

internal extension FeaturedGameParticipant {
    
    enum CodingKeys: String, CodingKey {
        case summonerName
        case profileIconID      = "profileIconId"
        case championID         = "championId"
        case isBot              = "bot"
        case teamID             = "teamId"
        case summonerSpellTwoID = "spell2Id"
        case summonerSpellOneID = "spell1Id"
    }
}
