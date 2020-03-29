//
//  ImageAsset.swift
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

enum ImageAsset: APIResource {
    
    case splashArt              (_ championID: String, _ skinIndex: Int)
    case loadingScreenArt       (_ championID: String, _ skinIndex: Int)
    case runesReforgedIcon      (_ urlPath: String)
    case runesReforgedPathIcon  (_ urlPath: String)
    case championThumbnail      (_ championID: String)
    case passive                (_ filename: String)
    case spell                  (_ filename: String)
    case item                   (_ itemID: String)
    case summonerSpell          (_ spellID: String)
    case profileIcon            (_ iconID: String)
    case minimap                (_ mapID: String)
    case spriteSheet            (_ filename: String)
    case scoreboardIcon         (_ iconType: ScoreboardIcon)
    
    func endpointURL(from baseURL: URL) -> URL {
        switch self {
        case .splashArt(let championID, let skinIndex):
            return baseURL.appendingPathComponents("champion", "splash", "\(championID)_\(skinIndex)").jpg()
        
        case .loadingScreenArt(let championID, let skinIndex):
            return baseURL.appendingPathComponents("champion", "loading", "\(championID)_\(skinIndex)").jpg()
        
        case .runesReforgedIcon(let urlPath):
            return baseURL.appendingPathComponent(urlPath)
        
        case .runesReforgedPathIcon(let urlPath):
            return baseURL.appendingPathComponent(urlPath)
        
        case .championThumbnail(let championID):
            return baseURL.appendingPathComponents("champion", championID).png()
        
        case .passive(let filename):
            return baseURL.appendingPathComponents("passive", filename).png()
        
        case .spell(let filename):
            return baseURL.appendingPathComponents("spell", filename).png()
        
        case .item(let itemID):
            return baseURL.appendingPathComponents("item", itemID).png()
        
        case .summonerSpell(let spellID):
            return baseURL.appendingPathComponents("spell", spellID).png()
        
        case .profileIcon(let iconID):
            return baseURL.appendingPathComponents("profileicon", iconID).png()
        
        case .minimap(let mapID):
            return baseURL.appendingPathComponents("map", mapID).png()
        
        case .spriteSheet(let filename):
            return baseURL.appendingPathComponents("sprite", filename).png()
            
        case .scoreboardIcon(let icon):
            return baseURL.appendingPathComponents("ui", icon.rawValue).png()
        }
    }
}
