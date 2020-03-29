//
//  Nexus.swift
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

public struct Nexus {
    
    public enum APIKeyPolicy {
        case includeAsHeaderParameter
        case includeAsQueryParameter
    }
    
    public static var apiKeyPolicy: APIKeyPolicy = .includeAsHeaderParameter
    
    public private(set) static var apiKey: String?
    
    public static func setApiKey(_ apiKey: String) {
        guard Nexus.apiKey == nil else {
            // TODO: log error
            return
        }
        guard !apiKey.isEmpty else {
            fatalError("Trying to assign an empty API key to Nexus.")
        }
        Nexus.apiKey = apiKey
    }
    
    public static func riotAPI(region: Region) throws -> RiotAPI {
        try RiotAPI(region: region)
    }
    
    public static func staticAPI() -> StaticAPI {
        StaticAPI()
    }
    
    public static func dataDragonAPI() -> DataDragonAPI {
        DataDragonAPI()
    }
    
    public static func dataDragon(region: Region) -> DataDragon {
        DataDragon(region: region)
    }
}
