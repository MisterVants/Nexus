//
//  Match.swift
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

public struct Match: Codable {
    
    /// The ID value of the match.
    public let gameId: Int
    
    /// The ID value of the season. Please refer to the Game Constants documentation.
    public let seasonId: Int
    
    /// The ID value of the queue. Please refer to the Game Constants documentation.
    public let queueId: Int
    
    /// The major.minor version typically indicates the patch the match was played on.
    public let gameVersion: String
    
    /// The ID value for the platform in which the match was played.
    public let platformId: String
    
    /// The game mode that was played. Please refer to the Game Constants documentation.
    public let gameMode: String
    
    /// The ID value of the map. Please refer to the Game Constants documentation.
    public let mapId: Int
    
    /// The type of the game that was played. Please refer to the Game Constants documentation.
    public let gameType: String
    
    /// Match duration in seconds.
    public let gameDuration: Int
    
    /// Designates the timestamp when champion select ended and the loading screen appeared, NOT when the game timer was at 0:00.
    public let gameCreation: Int
    
    /// Participant identity information.
    public let participantIdentities: [MatchParticipantIdentity]
    
    /// Team information.
    public let teams: [TeamStats]
    
    /// Participant information.
    public let participants: [MatchParticipant]
}
