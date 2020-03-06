//
//  Realm.swift
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

public protocol LivePatchVersions {
    //    var liveVersion: String {get}
}

public struct Realm: Decodable {
    let n: LiveVersions
    let v: String
    let l: String
    let cdn: String
    /// Latest changed version of Dragon Magic.
    let dd: String
    /// Legacy script mode for IE6 or older.
    let lg: String
    /// Latest changed version of Dragon Magic's CSS file.
    let css: String
    let profileiconmax: Int
    /// Additional API data drawn from other sources that may be related to Data Dragon functionality.
    let store: String?
}

extension Realm {
    /// Latest changed version for each data type listed.
    public var liveVersions: LiveVersions {
        return n
    }
    /// Current version of this file for this realm.
    public var version: String {
        return v
    }
    /// Default language's locale identifier for this realm.
    public var localeDefault: String {
        return l
    }
    /// The base URL for Data Dragon's Content Delivery Network.
    public var cdnUrl: String {
        return cdn
    }
    /// Special behavior number identifying the largest profile icon ID that can be used under 500. Any profile icon that is requested between this number and 500 should be mapped to 0.
    public var profileIconMaxID: Int {
        return profileiconmax
    }
}

public struct LiveVersions: Decodable {
    public let item: String
    public let rune: String
    public let mastery: String
    public let summoner: String
    public let champion: String
    public let profileicon: String
    public let map: String
    public let language: String
    public let sticker: String
    
    public var `default`: String {
        return champion // TODO: - Decode Realm manually to make an upward connection and return realm default version
    }
}
