//
//  MatchParticipant.swift
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

public struct MatchParticipant: Codable {
    
    /// The ID value of this participant.
    public let participantID: Int
    
    /// The team ID: 100 for blue side, 200 for red side.
    public let teamID: Int
    
    /// The ID value of the champion played during the match.
    public let championID: Int
    
    /// The first Summoner Spell ID.
    public let summonerSpellOneID: Int
    
    /// The second Summoner Spell ID.
    public let summonerSpellTwoID: Int
    
    /// Highest ranked tier achieved for the previous season in a specific subset of queue IDs, if any, otherwise nil. Used to display border in game loading screen. Please refer to the Ranked Info documentation. (Legal values: CHALLENGER, MASTER, DIAMOND, PLATINUM, GOLD, SILVER, BRONZE, UNRANKED)
    public let highestAchievedSeasonTier: String?
    
    /// Match statistics for the participant.
    public let stats: MatchParticipantStats
    
    /// Match timeline data for the participant.
    public let timeline: MatchParticipantTimeline
    
    /// List of legacy Rune information. Not included for matches played with Runes Reforged.
    public let runes: [MatchLegacyRune]?
    
    /// List of legacy Mastery information. Not included for matches played with Runes Reforged.
    public let masteries: [MatchLegacyMastery]?
}

internal extension MatchParticipant {

    enum CodingKeys: String, CodingKey {
        case stats, timeline, highestAchievedSeasonTier, runes, masteries
        case participantID      = "participantId"
        case teamID             = "teamId"
        case summonerSpellTwoID = "spell2Id"
        case summonerSpellOneID = "spell1Id"
        case championID         = "championId"
    }
}
