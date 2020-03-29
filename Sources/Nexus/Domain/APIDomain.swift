//
//  APIDomain.swift
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

fileprivate enum DomainName: String {
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
    
    public func asURL() throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = urlScheme
        urlComponents.host = hostname
        return try urlComponents.asURL()
    }
}

extension APIDomain where Self == RiotAPI {
    
    public var hostname: String {
        "\(self.region.platform).\(DomainName.riotAPI.rawValue)"
    }
}

extension APIDomain where Self == StaticAPI {
    
    public var hostname: String {
        DomainName.staticAPI.rawValue
    }
}

extension APIDomain where Self == DataDragonAPI {
    
    public var hostname: String {
        DomainName.dataDragon.rawValue
    }
}
