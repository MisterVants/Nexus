//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 05/03/20.
//

import Foundation

enum ImageResource: APIMethod {
    
    case splashArt(_ championID: String, _ skinIndex: Int)
    case loadingScreenArt(_ championID: String, _ skinIndex: Int)
    case runesReforgedIcon(_ urlPath: String)
    case runesReforgedPathIcon(_ urlPath: String)
    case championThumbnail(_ championID: String)
    case passive(_ filename: String)
    case spell(_ filename: String)
    case item(_ itemID: String)
    case summonerSpell(_ spellID: String)
    case profileIcon(_ iconID: String)
    case minimap(_ mapID: String)
    case spriteSheet(_ filename: String)
    case scoreboardIcon(_ iconType: ScoreboardIcon)
    
    var methodSignature: String { fatalError()} // FIXME
    
    func endpointPath(from baseURL: URL) -> URL {
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
