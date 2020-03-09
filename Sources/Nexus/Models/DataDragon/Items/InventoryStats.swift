//
//  InventoryDataStats.swift
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

public struct InventoryDataStats: Codable {
    public let PercentCritDamageMod: Double?
    public let PercentSpellBlockMod: Double?
    public let PercentHPRegenMod: Double?
    public let PercentMovementSpeedMod: Double?
    public let FlatSpellBlockMod: Double?
    public let FlatCritDamageMod: Double?
    public let FlatEnergyPoolMod: Double?
    public let PercentLifeStealMod: Double?
    public let FlatMPPoolMod: Double?
    public let FlatMovementSpeedMod: Double?
    public let PercentAttackSpeedMod: Double?
    public let FlatBlockMod: Double?
    public let PercentBlockMod: Double?
    public let FlatEnergyRegenMod: Double?
    public let PercentSpellVampMod: Double?
    public let FlatMPRegenMod: Double?
    public let PercentDodgeMod: Double?
    public let FlatAttackSpeedMod: Double?
    public let FlatArmorMod: Double?
    public let FlatHPRegenMod: Double?
    public let PercentMagicDamageMod: Double?
    public let PercentMPPoolMod: Double?
    public let FlatMagicDamageMod: Double?
    public let PercentMPRegenMod: Double?
    public let PercentPhysicalDamageMod: Double?
    public let FlatPhysicalDamageMod: Double?
    public let PercentHPPoolMod: Double?
    public let PercentArmorMod: Double?
    public let PercentCritChanceMod: Double?
    public let PercentEXPBonus: Double?
    public let FlatHPPoolMod: Double?
    public let FlatCritChanceMod: Double?
    public let FlatEXPBonus: Double?
}
