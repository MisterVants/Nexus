//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 05/03/20.
//

import Foundation

enum StaticDataResource: APIMethod {
    
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
    
    var methodSignature: String {
        fatalError()
    }
    
    func endpointPath(from baseURL: URL) -> URL {
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
        default:
            fatalError()
        }
    }
}
