//
//  Summoner.swift
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

public struct Summoner: Codable {
    
    /// The summoner's name.
    public let name: String
    
    /// The summoner level associated with the summoner.
    public let summonerLevel: Int
    
    /// The ID of the summoner icon associated with the summoner.
    public let profileIconID: Int
    
    /// The encrypted PUUID (Player Unique Universal ID). Exact length of 78 characters.
    public let puuid: String
    
    /// The encrypted summoner ID. Max length 63 characters.
    public let summonerID: String
    
    /// The encrypted account ID. Max length 56 characters.
    public let accountID: String
    
    /// Date summoner was last modified specified as epoch milliseconds. The following events will update this timestamp: profile icon change, playing the tutorial or advanced tutorial, finishing a game, summoner name change
    public let revisionDate: Int
}

internal extension Summoner {
    
    enum CodingKeys: String, CodingKey {
        case name, puuid, summonerLevel, revisionDate
        case profileIconID  = "profileIconId"
        case summonerID     = "id"
        case accountID      = "accountId"
    }
}
