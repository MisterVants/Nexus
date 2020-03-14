//
//  MatchReference.swift
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

public struct MatchReference: Codable {
    
    /// The ID value of the match. Can be used as parameter for /matches/{matchId} endpoint method.
    let gameID: Int
    
    /// The ID value for the platform in which the match was played.
    let platformID: String
    
    /// The ID value of the season. Please refer to the Game Constants documentation.
    let seasonID: Int
    
    /// The ID value of the queue. Please refer to the Game Constants documentation.
    let queueId: Int
    
    /// The ID value of the champion played during the match.
    let championID: Int
    
    let lane: String?
    let role: String?
    let timestamp: Int
}

extension MatchReference {
    
    enum CodingKeys: String, CodingKey {
        case lane, role, timestamp
        case gameID     = "gameId"
        case championID = "champion"
        case platformID = "platformId"
        case seasonID   = "season"
        case queueId    = "queue"
    }
}
