//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 02/03/20.
//

public struct LeagueList: Codable {
    
    /// The UUID of the league.
    let id: String?
    
    /// The ranked queue type for the league.
    let queue: String?
    
    /// The ranked tier of the league.
    let tier: String
    
    /// The name of the league.
    let name: String?
    
    /// A list of entries currently assigned to this league.
    let entries: [LeagueItem]
}

internal extension LeagueList {
    
    enum CodingKeys: String, CodingKey {
        case id = "leagueId"
        case tier
        case entries
        case queue
        case name
    }
}
