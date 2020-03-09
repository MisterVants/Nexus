//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 08/03/20.
//

public struct SummonerSpell {
    public let id: String
    public let name: String
    public let descriptionText: String  // sanitized description
    public let tooltip: String          // detailed description with markdown
    public let maxRank: Int
    public let cooldown: [Double]
    public let cooldownBurn: String
    public let cost: [Int]
    public let costBurn: String
    public let effect: [[Double]?]
    public let effectBurn: [String?]
    public let vars: [SpellVars]
    public let key: String
    public let summonerLevel: Int
    public let modes: [String]
    public let costType: String
    public let maxammo: String
    public let range: [Int]
    public let rangeBurn: String
    public let image: ImageMetadata
    public let resource: String?
}

extension SummonerSpell: Decodable {
    
    enum SpellKeys: String, CodingKey {
        case vars
        case image
        case costBurn
        case cooldown
        case effectBurn
        case id
        case cooldownBurn
        case tooltip
        case maxrank
        case rangeBurn
        case description
//        case descriptionText = "description"
        case effect
        case key
        case modes
        case resource
        case name
        case costType
        case maxammo
        case range
        case cost
        case summonerLevel
    }

    public init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: SpellKeys.self)
        
        let id              = try container.decode(String.self, forKey: .id)
        let name            = try container.decode(String.self, forKey: .name)
        let description     = try container.decode(String.self, forKey: .description)
        let tooltip         = try container.decode(String.self, forKey: .tooltip)
        let maxrank         = try container.decode(Int.self, forKey: .maxrank)
        let cooldown        = try container.decode([Double].self, forKey: .cooldown)
        let cooldownBurn    = try container.decode(String.self, forKey: .cooldownBurn)
        let cost            = try container.decode([Int].self, forKey: .cost)
        let costBurn        = try container.decode(String.self, forKey: .costBurn)
        let effect          = try container.decode([[Double]?].self, forKey: .effect)
        let effectBurn      = try container.decode([String?].self, forKey: .effectBurn)
        let vars            = try container.decode([SpellVars].self, forKey: .vars)
        let key             = try container.decode(String.self, forKey: .key)
        let summonerLevel   = try container.decode(Int.self, forKey: .summonerLevel)
        let modes           = try container.decode([String].self, forKey: .modes)
        let costType        = try container.decode(String.self, forKey: .costType)
        let maxammo         = try container.decode(String.self, forKey: .maxammo)
        let range           = try container.decode([Int].self, forKey: .range)
        let rangeBurn       = try container.decode(String.self, forKey: .rangeBurn)
        let image           = try container.decode(ImageMetadata.self, forKey: .image)
        let resource        = try? container.decode(String.self, forKey: .resource)
        
        self.init(id: id,
                  name: name,
                  descriptionText: description,
                  tooltip: tooltip,
                  maxRank: maxrank,
                  cooldown: cooldown,
                  cooldownBurn: cooldownBurn,
                  cost: cost,
                  costBurn: costBurn,
                  effect: effect,
                  effectBurn: effectBurn,
                  vars: vars,
                  key: key,
                  summonerLevel: summonerLevel,
                  modes: modes,
                  costType: costType,
                  maxammo: maxammo,
                  range: range,
                  rangeBurn: rangeBurn,
                  image: image,
                  resource: resource)
    }
}

extension SummonerSpell: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SpellKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(descriptionText, forKey: .description)
        try container.encode(tooltip, forKey: .tooltip)
        try container.encode(maxRank, forKey: .maxrank)
        try container.encode(cooldown, forKey: .cooldown)
        try container.encode(cooldownBurn, forKey: .cooldownBurn)
        try container.encode(cost, forKey: .cost)
        try container.encode(costBurn, forKey: .costBurn)
        try container.encode(effect, forKey: .effect)
        try container.encode(effectBurn, forKey: .effectBurn)
        try container.encode(vars, forKey: .vars)
        try container.encode(key, forKey: .key)
        try container.encode(summonerLevel, forKey: .summonerLevel)
        try container.encode(modes, forKey: .modes)
        try container.encode(costType, forKey: .costType)
        try container.encode(maxammo, forKey: .maxammo)
        try container.encode(range, forKey: .range)
        try container.encode(rangeBurn, forKey: .rangeBurn)
        try container.encode(image, forKey: .image)
        try container.encode(resource, forKey: .resource)
    }
}
