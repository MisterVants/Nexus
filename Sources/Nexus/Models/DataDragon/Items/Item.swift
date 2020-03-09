//
//  Item.swift
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

public struct Item: Codable {
    public let name: String
    public let descriptionText: String
    public let plainText: String
    public let goldInfo: ItemGoldData
    public let image: ImageMetadata
    public let stats: InventoryDataStats
    public let tags: [String]
    public let maps: [String : Bool]
    public let colloq: String
    public let fromItems: [String]?
    public let intoItems: [String]?
    public let depth: Int?
    public let specialRecipeID: Int?
    public let stacks: Int?
    public let requiredChampion: String?
    public let isAvailableInStore: Bool?
    public let isHiddenFromAll: Bool?
    public let isConsumable: Bool?
    public let canConsumeOnFull: Bool?
    public let effect: [String : String]?
}

extension Item {
    
    enum CodingKeys: String, CodingKey {
        case name, image, stats, tags, maps, colloq, depth, stacks, effect, requiredChampion
        case descriptionText    = "description"
        case plainText          = "plaintext"
        case goldInfo           = "gold"
        case fromItems          = "from"
        case intoItems          = "into"
        case specialRecipeID    = "specialRecipe"
        case isAvailableInStore = "inStore"
        case isHiddenFromAll    = "hideFromAll"
        case isConsumable       = "consumed"
        case canConsumeOnFull   = "consumeOnFull"
    }
}
