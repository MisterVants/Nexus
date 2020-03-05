//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 27/02/20.
//

public struct Champion: Codable {

    /// A string that identifies the champion.
    public let id: String

    /// A number string that uniquely identifies the champion.
    public let key: String

    /// The champion's name string.
    public let name: String

    /// The champion's title string.
    public let title: String

    public let blurb: String // lore reduced

    public let lore: String?

    public let tags: [String] // mage, fighter, etc

    public let allytips: [String]?

    public let enemytips: [String]?
}

public struct ChampionDto: Codable {
    public let data: [String : Champion]
    public let version: String
    public let type: String
    internal let format: String
}
