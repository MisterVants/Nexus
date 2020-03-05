//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 05/03/20.
//

import Foundation

enum ImageResource: APIMethod {
    case championThumbnail(_ championID: String)
    
    var methodSignature: String { fatalError()}
    
    func endpointPath(from baseURL: URL) -> URL {
        switch self {
        case .championThumbnail(let championID):
            return baseURL.appendingPathComponents("champion", championID).png()
        }
    }
}
