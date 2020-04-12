//
//  MatchParticipantTimeline.swift
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

public struct MatchParticipantTimeline: Codable {
    
    /// The ID value of this participant.
    public let participantID: Int
    
    /// Participant's calculated lane. MID and BOT are legacy values. (Legal values: MID, MIDDLE, TOP, JUNGLE, BOT, BOTTOM)
    public let lane: String?
    
    /// Participant's calculated role. (Legal values: DUO, NONE, SOLO, DUO_CARRY, DUO_SUPPORT)
    public let role: String?
    
    /// Gold value for a specified period.
    public let goldPerMinuteDeltas: [String : Double]?
    
    /// Experience change for a specified period.
    public let experiencePerMinuteDeltas: [String : Double]?
    
    /// Experience difference versus the calculated lane opponent(s) for a specified period.
    public let experienceDiffPerMinuteDeltas: [String : Double]?
    
    /// Creeps score for a specified period.
    public let creepsPerMinuteDeltas: [String : Double]?
    
    /// Creep score difference versus the calculated lane opponent(s) for a specified period.
    public let creepScoreDiffPerMinuteDeltas: [String : Double]?
    
    /// Damage taken for a specified period.
    public let damageTakenPerMinuteDeltas: [String : Double]?
    
    /// Damage taken difference versus the calculated lane opponent(s) for a specified period.
    public let damageTakenDiffPerMinuteDeltas: [String : Double]?
}

internal extension MatchParticipantTimeline {
    
    enum CodingKeys: String, CodingKey {
        case lane, role
        case participantID                  = "participantId"
        case creepScoreDiffPerMinuteDeltas  = "csDiffPerMinDeltas"
        case goldPerMinuteDeltas            = "goldPerMinDeltas"
        case experienceDiffPerMinuteDeltas  = "xpDiffPerMinDeltas"
        case creepsPerMinuteDeltas          = "creepsPerMinDeltas"
        case experiencePerMinuteDeltas      = "xpPerMinDeltas"
        case damageTakenDiffPerMinuteDeltas = "damageTakenDiffPerMinDeltas"
        case damageTakenPerMinuteDeltas     = "damageTakenPerMinDeltas"
    }
}
