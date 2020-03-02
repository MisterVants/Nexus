//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 27/02/20.
//

// These are the only methods used by Riot API. GET is the most used.
internal enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}
