//
//  CurrentGameInfo.swift
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

public struct CurrentGameInfo: Codable {
    
    /// The ID value of the game.
    let gameId: Int
    
    /// The ID value of the platform on which the game is being played.
    let platformId: String
    
    /// The queue type (queue types are documented on the Game Constants page).
    let gameQueueConfigId: Int
    
    /// The ID value of the map.
    let mapId: Int
    
    /// The game mode being played.
    let gameMode: String
    
    /// The game type being played.
    let gameType: String
    
    /// The game start time represented in epoch milliseconds.
    let gameStartTime: Int
    
    /// The amount of time in seconds that has passed since the game started.
    let gameLength: Int
    
    /// The observer information.
    let observers: Observer
    
    /// Banned champions information.
    let bannedChampions: [BannedChampion]
    
    /// The game participant information.
    let participants: [CurrentGameParticipant]
}
