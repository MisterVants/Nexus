//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 02/03/20.
//

import Foundation

fileprivate enum Domain: String {
    case riotAPI    = "api.riotgames.com"
    case staticAPI  = "static.developer.riotgames.com"
    case dataDragon = "ddragon.leagueoflegends.com"
}

public protocol APIDomain: URLConvertible {
    var urlScheme: String {get}
    var hostname: String {get}
}

extension APIDomain {
    public var urlScheme: String { "https" }
}

extension APIDomain where Self == RiotAPI {
    
    public var hostname: String {
        "\(self.region.platform).\(Domain.riotAPI.rawValue)"
    }
}

extension APIDomain where Self == StaticAPI {
    
    public var hostname: String {
        Domain.staticAPI.rawValue
    }
}

extension APIDomain where Self == DataDragonAPI {
    
    public var hostname: String {
        Domain.dataDragon.rawValue
    }
}

extension APIDomain {
    
    public func asURL() throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = urlScheme
        urlComponents.host = hostname
        return try urlComponents.asURL()
    }
}
