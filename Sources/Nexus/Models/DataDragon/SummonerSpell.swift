//
//  SummonerSpell.swift
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
    public let maxAmmo: String
    public let range: [Int]
    public let rangeBurn: String
    public let image: ImageMetadata
    public let resource: String?
}

extension SummonerSpell: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case descriptionText = "description"
        case tooltip
        case maxRank = "maxrank"
        case cooldown
        case cooldownBurn
        case cost
        case costBurn
        case effect
        case effectBurn
        case vars
        case key
        case summonerLevel
        case modes
        case costType
        case maxAmmo = "maxammo"
        case range
        case rangeBurn
        case image
        case resource
    }
}
