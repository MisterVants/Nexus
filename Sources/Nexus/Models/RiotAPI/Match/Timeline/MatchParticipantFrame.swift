//
//  MatchParticipantFrame.swift
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

public struct MatchParticipantFrame: Codable {
    public let participantID: Int
    public let level: Int?
    public let experiencePoints: Int?
    public let totalGold: Int?
    public let currentGold: Int?
    public let minionsKilled: Int?
    public let jungleMinionsKilled: Int?
    public let position: MatchPosition?
    public let teamScore: Int?
    public let dominionScore: Int?
}

internal extension MatchParticipantFrame {
    
    enum CodingKeys: String, CodingKey {
        case totalGold
        case teamScore
        case participantID = "participantId"
        case level
        case currentGold
        case minionsKilled
        case dominionScore
        case position
        case experiencePoints = "xp"
        case jungleMinionsKilled
    }
}
