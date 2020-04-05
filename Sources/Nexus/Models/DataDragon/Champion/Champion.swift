//
//  Champion.swift
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

public struct Champion: Codable {

    /// A string that identifies the champion.
    public let id: String

    /// A number string that uniquely identifies the champion.
    public let key: String

    /// The champion's name string.
    public let name: String

    /// The champion's title string.
    public let title: String

    public let tags: [String] // mage, fighter, etc
    
    public let resourceType: String
    
    public let blurb: String // lore reduced

    public let lore: String?

    public let allyTips: [String]?

    public let enemyTips: [String]?
    
    public let image: ImageMetadata
    
    public let info: ChampionInfo
    
    public let stats: ChampionStats

    public let skins: [ChampionSkin]?

    public let spells: [ChampionSpell]?

    public let passive: ChampionPassive?
}

extension Champion {
    
    enum CodingKeys: String, CodingKey {
        case id, key, name, title, tags, blurb, lore, image, info, stats, skins, spells, passive
        case allyTips       = "allytips"
        case enemyTips      = "enemytips"
        case resourceType   = "partype"
    }
}
