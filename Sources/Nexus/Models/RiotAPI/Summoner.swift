//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 05/03/20.
//

public struct Summoner: Codable {
    
    /// The summoner's name.
    let name: String
    
    /// The summoner level associated with the summoner.
    let summonerLevel: Int
    
    /// The ID of the summoner icon associated with the summoner.
    let profileIconID: Int
    
    /// The encrypted PUUID (Player Unique Universal ID). Exact length of 78 characters.
    let puuid: String
    
    /// The encrypted summoner ID. Max length 63 characters.
    let summonerID: String
    
    /// The encrypted account ID. Max length 56 characters.
    let accountID: String
    
    /// Date summoner was last modified specified as epoch milliseconds. The following events will update this timestamp: profile icon change, playing the tutorial or advanced tutorial, finishing a game, summoner name change
    let revisionDate: Int
}

internal extension Summoner {
    
    enum CodingKeys: String, CodingKey {
        case name, puuid, summonerLevel, revisionDate
        case profileIconID  = "profileIconId"
        case summonerID     = "id"
        case accountID      = "accountId"
    }
}
