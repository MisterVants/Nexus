//
//  CurrentGameParticipant.swift
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

public struct CurrentGameParticipant: Codable {
    
    /// The encrypted summoner ID of this participant.
    let summonerID: String
    
    /// The summoner name of this participant.
    let summonerName: String
    
    /// The ID of the profile icon used by this participant.
    let profileIconID: Int
    
    /// A boolean value indicating whether or not this participant is a bot.
    let isBot: Bool
    
    /// The team ID of this participant, indicating the participant's team.
    let teamID: Int
    
    /// The ID of the champion played by this participant.
    let championID: Int
    
    /// The ID of the first summoner spell used by this participant.
    let summonerSpellOneID: Int
    
    /// The ID of the second summoner spell used by this participant.
    let summonerSpellTwoID: Int
    
    /// Perks / Runes Reforged Information.
    let runesReforged: Perks
    
    /// List of Game Customizations.
    let gameCustomizationObjects: [GameCustomizationObject]
}

internal extension CurrentGameParticipant {
    
    enum CodingKeys: String, CodingKey {
        case summonerName, gameCustomizationObjects
        case profileIconID      = "profileIconId"
        case championID         = "championId"
        case isBot              = "bot"
        case runesReforged      = "perks"
        case summonerSpellOneID = "spell1Id"
        case summonerSpellTwoID = "spell2Id"
        case teamID             = "teamId"
        case summonerID         = "summonerId"
    }
}
