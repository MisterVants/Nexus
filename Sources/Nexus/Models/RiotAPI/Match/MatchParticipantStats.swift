//
//  MatchParticipantStats.swift
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

public struct MatchParticipantStats: Codable {
    
    let participantId: Int
    
    let win: Bool?
    let champLevel: Int?
    let totalScoreRank: Int?
    let totalPlayerScore: Int?
    let combatPlayerScore: Int?
    
    // MARK: - Combat
    
    let kills: Int?
    let deaths: Int?
    let assists: Int?
    
    let largestKillingSpree: Int?
    let largestMultiKill: Int?
    let totalTimeCrowdControlDealt: Int?
    let timeCCingOthers: Int?
    let firstBloodKill: Bool?
    let firstBloodAssist: Bool?
    let longestTimeSpentLiving: Int?
    
    let killingSprees: Int?
    let doubleKills: Int?
    let tripleKills: Int?
    let quadraKills: Int?
    let pentaKills: Int?
    let unrealKills: Int?
    
    // MARK: - Objectives
    
    let teamObjective: Int?
    let objectivePlayerScore: Int?
    let firstTowerKill: Bool?
    let firstTowerAssist: Bool?
    let firstInhibitorKill: Bool?
    let firstInhibitorAssist: Bool?
    
    // MARK: - Damage Dealt
    
    let totalDamageDealtToChampions: Int?
    let physicalDamageDealtToChampions: Int?
    let magicDamageDealtToChampions: Int?
    let trueDamageDealtToChampions: Int?
    let totalDamageDealt: Int?
    let physicalDamageDealt: Int?
    let magicDamageDealt: Int?
    let trueDamageDealt: Int?
    let largestCriticalStrike: Int?
    let damageDealtToTurrets: Int?
    let damageDealtToObjectives: Int?
    
    // MARK: - Damage Taken and Healed
    
    let totalHeal: Int?
    let totalDamageTaken: Int?
    let physicalDamageTaken: Int?
    let magicalDamageTaken: Int?
    let trueDamageTaken: Int?
    let damageSelfMitigated: Int?
    let totalUnitsHealed: Int?
    
    // MARK: - Vision
    
    let visionScore: Int?
    let wardsPlaced: Int?
    let wardsKilled: Int?
    let sightWardsBoughtInGame: Int?
    let visionWardsBoughtInGame: Int?
    
    // MARK: - Receipt
    
    let goldEarned: Int?
    let goldSpent: Int?
    let totalMinionsKilled: Int?
    let neutralMinionsKilled: Int?
    let neutralMinionsKilledTeamJungle: Int?
    let neutralMinionsKilledEnemyJungle: Int?
    
    // MARK: - Others
    
    let turretKills: Int?
    let inhibitorKills: Int?
    
    let altarsCaptured: Int?
    let altarsNeutralized: Int?
    
    let nodeCapture: Int?
    let nodeCaptureAssist: Int?
    let nodeNeutralize: Int?
    let nodeNeutralizeAssist: Int?
    
    // MARK: - Runes Reforged
    
    /// Primary rune path
    let perkPrimaryStyle: Int?
    /// Secondary rune path
    let perkSubStyle: Int?
    
    /// Primary path keystone rune.
    let perk0: Int?
    /// Primary path rune.
    let perk1: Int?
    /// Primary path rune.
    let perk2: Int?
    /// Primary path rune.
    let perk3: Int?
    
    /// Secondary path rune.
    let perk4: Int?
    /// Secondary path rune.
    let perk5: Int?
    
    // Post game rune stats.
    let perk0Var1: Int?
    let perk0Var2: Int?
    let perk0Var3: Int?
    
    let perk1Var1: Int?
    let perk1Var3: Int?
    let perk1Var2: Int?
    
    let perk2Var1: Int?
    let perk2Var2: Int?
    let perk2Var3: Int?
    
    let perk3Var1: Int?
    let perk3Var2: Int?
    let perk3Var3: Int?
    
    let perk4Var1: Int?
    let perk4Var2: Int?
    let perk4Var3: Int?
    
    let perk5Var1: Int?
    let perk5Var2: Int?
    let perk5Var3: Int?
    
    // Item IDs
    let item0: Int?
    let item1: Int?
    let item2: Int?
    let item3: Int?
    let item4: Int?
    let item5: Int?
    let item6: Int?
    
    let playerScore0: Int?
    let playerScore1: Int?
    let playerScore2: Int?
    let playerScore3: Int?
    let playerScore4: Int?
    let playerScore5: Int?
    let playerScore6: Int?
    let playerScore7: Int?
    let playerScore8: Int?
    let playerScore9: Int?
}

