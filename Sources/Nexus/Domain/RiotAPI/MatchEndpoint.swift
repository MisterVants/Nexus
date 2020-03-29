//
//  MatchEndpoint.swift
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

import Foundation

public protocol MatchEndpoint {
    func getMatch(byID matchID: Int, completion: @escaping (Response<Match>) -> Void)
    func getMatchlist(byAccountID encryptedAccountID: String, completion: @escaping (Response<MatchList>) -> Void)
    func getTimeline(byMatchID matchID: Int, completion: @escaping (Response<MatchTimeline>) -> Void)
}

struct MatchAPI: APIEndpoint {
    typealias Method = MatchMethod
    let domain: APIDomain
    let provider: RateLimitedProvider
    let endpoint: RiotAPI.Endpoint = .match
}

extension MatchAPI {
    
    enum MatchMethod: APIMethod {
        case match(_ id: Int)
        case matchlist(_ encryptedAccountID: String)
        case timeline(_ matchID: Int)
        
        var signature: String {
            switch self {
            case .match:        return "match"
            case .matchlist:    return "matchlist"
            case .timeline:     return "timeline"
            }
        }
        
        func endpointURL(from baseURL: URL) -> URL {
            switch self {
            case .match(let id):
                return baseURL.appendingPathComponents("matches", "\(id)")
            case .matchlist(let encryptedAccountID):
                return baseURL.appendingPathComponents("matchlists/by-account", encryptedAccountID)
            case .timeline(let matchID):
                return baseURL.appendingPathComponents("timelines/by-match", "\(matchID)")
            }
        }
    }
}

extension MatchAPI: MatchEndpoint {
    
    func getMatch(byID matchID: Int, completion: @escaping (Response<Match>) -> Void) {
        request(.match(matchID), completion: completion)
    }
    
    func getMatchlist(byAccountID encryptedAccountID: String, completion: @escaping (Response<MatchList>) -> Void) {
        request(.matchlist(encryptedAccountID), completion: completion)
    }
    
    func getTimeline(byMatchID matchID: Int, completion: @escaping (Response<MatchTimeline>) -> Void) {
        request(.timeline(matchID), completion: completion)
    }
}
