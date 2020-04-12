//
//  MatchPlayer.swift
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

public struct MatchPlayer: Codable {
    
    /// The summoner's name.
    public let summonerName: String
    
    /// The URI poiting to the player's match history.
    public let matchHistoryURI: String
    
    /// The ID of the summoner icon associated with the player.
    public let profileIcon: Int
    
    /// The player's original platform ID.
    public let platformID: String
    
    /// The player's current platform ID.
    public let currentPlatformID: String
    
    /// The player's original account ID (Encrypted)
    public let accountID: String
    
    /// The player's current accountId (Encrypted)
    public let currentAccountID: String
    
    /// The player's encrypted summoner ID.
    public let summonerID: String
}

internal extension MatchPlayer {
    
    enum CodingKeys: String, CodingKey {
        case summonerName, profileIcon
        case matchHistoryURI    = "matchHistoryUri"
        case platformID         = "platformId"
        case currentPlatformID  = "currentPlatformId"
        case accountID          = "accountId"
        case currentAccountID   = "currentAccountId"
        case summonerID         = "summonerId"
    }
}
