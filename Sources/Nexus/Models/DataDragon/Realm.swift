//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 29/02/20.
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
