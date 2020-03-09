//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 05/03/20.
//

public struct Item {
    public let name: String
    public let descriptionText: String
    public let colloq: String
    public let plaintext: String
    public let specialRecipe: Int?
    public let stacks: Int?
    public let consumed: Bool?
    public let consumeOnFull: Bool?
    public let inStore: Bool?
    public let requiredChampion: String?
    public let from: [String]?
    public let into: [String]?
    public let hideFromAll: Bool?
    public let image: ImageMetadata
    public let gold: ItemGoldData
    public let tags: [String]
    public let maps: [String : Bool]
    public let stats: InventoryDataStats
    public let effect: [String : String]?
    public let depth: Int?
}

extension Item: Decodable {
    
    enum ItemKeys: String, CodingKey {
        case gold
        case plaintext
        case hideFromAll
        case inStore
        case into
        case stats
        case colloq
        case maps
        case specialRecipe
        case image
        case description
        case tags
        case effect
        case requiredChampion
        case from
        case consumeOnFull
        case name
        case consumed
        case depth
        case stacks
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ItemKeys.self)
        
        let name                = try container.decode(String.self, forKey: .name)
        let description         = try container.decode(String.self, forKey: .description)
        let colloq              = try container.decode(String.self, forKey: .colloq)
        let plaintext           = try container.decode(String.self, forKey: .plaintext)
        let specialRecipe       = try? container.decode(Int.self, forKey: .specialRecipe)
        let stacks              = try? container.decode(Int.self, forKey: .stacks)
        let consumed            = try? container.decode(Bool.self, forKey: .consumed)
        let consumeOnFull       = try? container.decode(Bool.self, forKey: .consumeOnFull)
        let inStore             = try? container.decode(Bool.self, forKey: .inStore)
        let requiredChampion    = try? container.decode(String.self, forKey: .requiredChampion)
        let from                = try? container.decode([String].self, forKey: .from)
        let into                = try? container.decode([String].self, forKey: .into)
        let hideFromAll         = try? container.decode(Bool.self, forKey: .hideFromAll)
        let image               = try container.decode(ImageMetadata.self, forKey: .image)
        let gold                = try container.decode(ItemGoldData.self, forKey: .gold)
        let tags                = try container.decode([String].self, forKey: .tags)
        let maps                = try container.decode([String:Bool].self, forKey: .maps)
        let stats               = try container.decode(InventoryDataStats.self, forKey: .stats)
        let effect              = try? container.decode([String:String].self, forKey: .effect)
        let depth               = try? container.decode(Int.self, forKey: .depth)
        
        self.init(name: name,
                  descriptionText: description,
                  colloq: colloq,
                  plaintext: plaintext,
                  specialRecipe: specialRecipe,
                  stacks: stacks,
                  consumed: consumed,
                  consumeOnFull: consumeOnFull,
                  inStore: inStore,
                  requiredChampion: requiredChampion,
                  from: from,
                  into: into,
                  hideFromAll: hideFromAll,
                  image: image,
                  gold: gold,
                  tags: tags,
                  maps: maps,
                  stats: stats,
                  effect: effect,
                  depth: depth)
    }
}

extension Item: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ItemKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(descriptionText, forKey: .description)
        try container.encode(colloq, forKey: .colloq)
        try container.encode(plaintext, forKey: .plaintext)
        try container.encode(specialRecipe, forKey: .specialRecipe)
        try container.encode(stacks, forKey: .stacks)
        try container.encode(consumed, forKey: .consumed)
        try container.encode(consumeOnFull, forKey: .consumeOnFull)
        try container.encode(inStore, forKey: .inStore)
        try container.encode(requiredChampion, forKey: .requiredChampion)
        try container.encode(from, forKey: .from)
        try container.encode(into, forKey: .into)
        try container.encode(hideFromAll, forKey: .hideFromAll)
        try container.encode(image, forKey: .image)
        try container.encode(gold, forKey: .gold)
        try container.encode(tags, forKey: .tags)
        try container.encode(maps, forKey: .maps)
        try container.encode(stats, forKey: .stats)
        try container.encode(effect, forKey: .effect)
        try container.encode(depth, forKey: .depth)
    }
}
