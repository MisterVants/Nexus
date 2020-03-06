//
//  ChampionStats.swift
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

public struct ChampionStats: Codable {
    
    public let hp: Double
    public let hpPerLevel: Double
    public let hpRegen: Double
    public let hpRegenPerLevel: Double
    public let mp: Double
    public let mpPerLevel: Double
    public let mpRegen: Double
    public let mpRegenPerLevel: Double
    public let armor: Double
    public let armorPerLevel: Double
    public let magicResist: Double
    public let magicResistPerLevel: Double
    public let attackDamage: Double
    public let attackDamagePerLevel: Double
    public let attackSpeed: Double
    public let attackSpeedPerLevel: Double
    public let attackRange: Double
    public let movespeed: Double
    public let crit: Double
    public let critPerLevel: Double
}

extension ChampionStats {
    
    enum CodingKeys: String, CodingKey {
        case hp, mp, armor, movespeed, crit
        case hpPerLevel             = "hpperlevel"
        case hpRegen                = "hpregen"
        case hpRegenPerLevel        = "hpregenperlevel"
        case mpPerLevel             = "mpperlevel"
        case mpRegen                = "mpregen"
        case mpRegenPerLevel        = "mpregenperlevel"
        case armorPerLevel          = "armorperlevel"
        case magicResist            = "spellblock"
        case magicResistPerLevel    = "spellblockperlevel"
        case attackDamage           = "attackdamage"
        case attackDamagePerLevel   = "attackdamageperlevel"
        case attackSpeed            = "attackspeed"
        case attackSpeedPerLevel    = "attackspeedperlevel"
        case attackRange            = "attackrange"
        case critPerLevel           = "critperlevel"
    }
}
