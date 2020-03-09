//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 09/03/20.
//

public struct Map: Codable {
    
    /// A string describing the name of the game map.
    public var mapName: String { return MapName }
    private let MapName: String
    
    /// A string that uniquely identifies the game map.
    public var mapId: String { return MapId}
    private let MapId: String
    
    /// The map's image sprite parameters.
    public var imageMetadata: ImageMetadata { return image }
    private let image: ImageMetadata
}
