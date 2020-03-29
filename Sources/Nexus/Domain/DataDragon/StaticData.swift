//
//  StaticData.swift
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

enum StaticData: APIResource {
    
    case realm(_ region: Region)
    case languages
    case versions
    case champions
    case championDetail(_ championId: String)
    case items
    case runesReforged
    case summonerSpells
    case profileIcon
    case maps
    case localizedStrings
    
    func endpointURL(from baseURL: URL) -> URL {
        switch self {
        case .realm(let region):
            return baseURL.appendingPathComponents("realms", region.rawValue).json()
            
        case.languages:
            return baseURL.appendingPathComponents("cdn", "languages").json()
            
        case .versions:
            return baseURL.appendingPathComponents("api", "versions").json()
            
        case .champions:
            return baseURL.appendingPathComponent("champion").json()
            
        case .championDetail(let championID):
            return baseURL.appendingPathComponents("champion", championID).json()
            
        case .items:
            return baseURL.appendingPathComponent("item").json()
            
        case .runesReforged:
            return baseURL.appendingPathComponent("runesReforged").json()
            
        case .summonerSpells:
            return baseURL.appendingPathComponent("summoner").json()
            
        case .profileIcon:
            return baseURL.appendingPathComponent("profileicon").json()
            
        case .maps:
            return baseURL.appendingPathComponent("map").json()
            
        case .localizedStrings:
            return baseURL.appendingPathComponent("language").json()
        }
    }
}
