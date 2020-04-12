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
    
    public let participantId: Int
    
    public let win: Bool?
    public let champLevel: Int?
    public let totalScoreRank: Int?
    public let totalPlayerScore: Int?
    public let combatPlayerScore: Int?
    
    // MARK: - Combat
    
    public let kills: Int?
    public let deaths: Int?
    public let assists: Int?
    
    public let largestKillingSpree: Int?
    public let largestMultiKill: Int?
    public let totalTimeCrowdControlDealt: Int?
    public let timeCCingOthers: Int?
    public let firstBloodKill: Bool?
    public let firstBloodAssist: Bool?
    public let longestTimeSpentLiving: Int?
    
    public let killingSprees: Int?
    public let doubleKills: Int?
    public let tripleKills: Int?
    public let quadraKills: Int?
    public let pentaKills: Int?
    public let unrealKills: Int?
    
    // MARK: - Objectives
    
    public let teamObjective: Int?
    public let objectivePlayerScore: Int?
    public let firstTowerKill: Bool?
    public let firstTowerAssist: Bool?
    public let firstInhibitorKill: Bool?
    public let firstInhibitorAssist: Bool?
    
    // MARK: - Damage Dealt
    
    public let totalDamageDealtToChampions: Int?
    public let physicalDamageDealtToChampions: Int?
    public let magicDamageDealtToChampions: Int?
    public let trueDamageDealtToChampions: Int?
    public let totalDamageDealt: Int?
    public let physicalDamageDealt: Int?
    public let magicDamageDealt: Int?
    public let trueDamageDealt: Int?
    public let largestCriticalStrike: Int?
    public let damageDealtToTurrets: Int?
    public let damageDealtToObjectives: Int?
    
    // MARK: - Damage Taken and Healed
    
    public let totalHeal: Int?
    public let totalDamageTaken: Int?
    public let physicalDamageTaken: Int?
    public let magicalDamageTaken: Int?
    public let trueDamageTaken: Int?
    public let damageSelfMitigated: Int?
    public let totalUnitsHealed: Int?
    
    // MARK: - Vision
    
    public let visionScore: Int?
    public let wardsPlaced: Int?
    public let wardsKilled: Int?
    public let sightWardsBoughtInGame: Int?
    public let visionWardsBoughtInGame: Int?
    
    // MARK: - Receipt
    
    public let goldEarned: Int?
    public let goldSpent: Int?
    public let totalMinionsKilled: Int?
    public let neutralMinionsKilled: Int?
    public let neutralMinionsKilledTeamJungle: Int?
    public let neutralMinionsKilledEnemyJungle: Int?
    
    // MARK: - Others
    
    public let turretKills: Int?
    public let inhibitorKills: Int?
    
    public let altarsCaptured: Int?
    public let altarsNeutralized: Int?
    
    public let nodeCapture: Int?
    public let nodeCaptureAssist: Int?
    public let nodeNeutralize: Int?
    public let nodeNeutralizeAssist: Int?
    
    // MARK: - Runes Reforged
    
    /// Primary rune path
    public let perkPrimaryStyle: Int?
    /// Secondary rune path
    public let perkSubStyle: Int?
    
    /// Primary path keystone rune.
    public let perk0: Int?
    /// Primary path rune.
    public let perk1: Int?
    /// Primary path rune.
    public let perk2: Int?
    /// Primary path rune.
    public let perk3: Int?
    
    /// Secondary path rune.
    public let perk4: Int?
    /// Secondary path rune.
    public let perk5: Int?
    
    // Post game rune stats.
    public let perk0Var1: Int?
    public let perk0Var2: Int?
    public let perk0Var3: Int?
    
    public let perk1Var1: Int?
    public let perk1Var3: Int?
    public let perk1Var2: Int?
    
    public let perk2Var1: Int?
    public let perk2Var2: Int?
    public let perk2Var3: Int?
    
    public let perk3Var1: Int?
    public let perk3Var2: Int?
    public let perk3Var3: Int?
    
    public let perk4Var1: Int?
    public let perk4Var2: Int?
    public let perk4Var3: Int?
    
    public let perk5Var1: Int?
    public let perk5Var2: Int?
    public let perk5Var3: Int?
    
    // Item IDs
    public let item0: Int?
    public let item1: Int?
    public let item2: Int?
    public let item3: Int?
    public let item4: Int?
    public let item5: Int?
    public let item6: Int?
    
    public let playerScore0: Int?
    public let playerScore1: Int?
    public let playerScore2: Int?
    public let playerScore3: Int?
    public let playerScore4: Int?
    public let playerScore5: Int?
    public let playerScore6: Int?
    public let playerScore7: Int?
    public let playerScore8: Int?
    public let playerScore9: Int?
}

