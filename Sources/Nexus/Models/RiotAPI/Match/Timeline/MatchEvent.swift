//
//  MatchEvent.swift
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

public struct MatchEvent: Codable {
    
    /// The type of the event. Legal values: CHAMPION_KILL, WARD_PLACED, WARD_KILL, BUILDING_KILL, ELITE_MONSTER_KILL, ITEM_PURCHASED, ITEM_SOLD, ITEM_DESTROYED, ITEM_UNDO, SKILL_LEVEL_UP, ASCENDED_EVENT, CAPTURE_POINT, PORO_KING_SUMMON
    public let type: String
    public let timestamp: Int
    public let teamID: Int?
    public let participantID: Int?
    public let assistingParticipantIDs: [Int]?
    public let position: MatchPosition?
    public let beforeID: Int?
    public let afterID: Int?
    public let creatorID: Int?
    public let eventType: String?
    public let laneType: String?
    public let killerID: Int?
    public let victimID: Int?
    public let wardType: String?
    public let buildingType: String?
    public let towerType: String?
    public let monsterType: String?
    public let monsterSubType: String?
    public let itemID: Int?
    public let skillSlot: Int?
    public let levelUpType: String?
    public let ascendedType: String?
    public let pointCaptured: String?
}

internal extension MatchEvent {

    enum CodingKeys: String, CodingKey {
        case timestamp
        case type
        case position
        case eventType
        case laneType
        case wardType
        case buildingType
        case towerType
        case monsterType
        case monsterSubType
        case skillSlot
        case levelUpType
        case ascendedType
        case pointCaptured
        case teamID                     = "teamId"
        case participantID              = "participantId"
        case assistingParticipantIDs    = "assistingParticipantIds"
        case beforeID                   = "beforeId"
        case afterID                    = "afterId"
        case creatorID                  = "creatorId"
        case killerID                   = "killerId"
        case victimID                   = "victimId"
        case itemID                     = "itemId"
    }
}
