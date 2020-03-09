//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 09/03/20.
//

/**
 A representation of a Profile Icon that can be used as a summoner avatar.
 */
public struct ProfileIcon: Codable {
    
    /// An integer that uniquely identifies the profile icon.
    public let id: Int
    
    /// The icon's image sprite parameters.
    public var imageMetadata: ImageMetadata { return image }
    private let image: ImageMetadata
}

