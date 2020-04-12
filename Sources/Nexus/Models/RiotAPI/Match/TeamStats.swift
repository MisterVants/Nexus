//
//  TeamStats.swift
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

public struct TeamStats: Codable {
    
    /// The team ID: 100 for blue side, 200 for red side.
    public let teamID: Int
    
    /// If match queueID has a draft, contains banned champion data, otherwise empty.
    public let bans: [TeamBan]
    
    /// A string indicating whether or not the team won. There are only two values visibile in public match history. (Legal values: Fail, Win)
    public let winStatus: String
    
    /// A boolean value indicating whether or not the team scored the first blood.
    public let hasScoredFirstBlood: Bool?
    
    /// A boolean value indicating whether or not the team scored the first Dragon kill.
    public let hasKilledFirstDragon: Bool?
    
    /// A boolean value indicating whether or not the team scored the first Rift Herald kill.
    public let hasKilledFirstRiftHerald: Bool?
    
    /// A boolean value indicating whether or not the team scored the first Baron kill.
    public let hasKilledFirstBaron: Bool?
    
    /// A boolean value indicating whether or not the team destroyed the first tower.
    public let hasDestroyedFirstTower: Bool?
    
    /// A boolean value indicating whether or not the team destroyed the first inhibitor.
    public let hasDestroyedFirstInhibitor: Bool?
    
    /// Number of times the team killed the Dragon.
    public let dragonKills: Int?
    
    /// Number of times the team killed the Rift Herald.
    public let riftHeraldKills: Int?
    
    /// Number of times the team killed the Baron.
    public let baronKills: Int?
    
    /// Number of towers the team destroyed.
    public let towerKills: Int?
    
    /// Number of inhibitors the team destroyed.
    public let inhibitorKills: Int?
    
    /// Number of times the team killed Vilemaw. (Twisted Treeline matches)
    public let vilemawKills: Int?
    
    /// For Dominion matches, specifies the points the team had at game end.
    public let dominionVictoryScore: Int?
}

internal extension TeamStats {
    
    enum CodingKeys: String, CodingKey {
        case bans, towerKills, inhibitorKills, dragonKills, riftHeraldKills, baronKills, vilemawKills, dominionVictoryScore
        case hasKilledFirstDragon       = "firstDragon"
        case hasDestroyedFirstInhibitor = "firstInhibitor"
        case hasKilledFirstRiftHerald   = "firstRiftHerald"
        case hasKilledFirstBaron        = "firstBaron"
        case hasScoredFirstBlood        = "firstBlood"
        case teamID                     = "teamId"
        case hasDestroyedFirstTower     = "firstTower"
        case winStatus                  = "win"
    }
}
