//
//  RunesReforged.swift
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


public enum RunesReforged {
    
    public struct Path: Codable {
        
        /// A unique 4-digit ID corresponding to the Rune Path's style.
        public let id: Int
        
        /// A string that identifies this Rune Path.
        public let key: String
        
        /// The in-game name of the Rune Path.
        public let name: String
        
        /// An array containing the rune slots for the corresponding path. The first element is the Keystone slot.
        public let slots: [Slot]
        
        /// A DataDragon CDN URL path to the icon for this Rune Path.
        public let iconPath: String //{ return icon }
        
        enum CodingKeys: String, CodingKey {
            case id, key, name, slots
            case iconPath = "icon"
        }
    }
    
    public struct Slot: Codable {
        
        /// An array containing all runes of the corresponding slot.
        public let runes: [Rune]
    }
    
    public struct Rune: Codable {
        
        /// A unique 4-digit ID corresponding to the Rune.
        public let id: Int
        
        /// A string identifier for this Rune.
        public let key: String
        
        /// The in-game name of the Rune
        public let name: String
        
        /// A DataDragon CDN URL path to the icon for this Rune.
        public let iconPath: String
        
        /// A string for the short description of the rune effects, formatted with rich-text tags.
        public let descriptionShort: String
        
        /// A string for the long description of the rune effects, formatted with rich-text tags.
        public let descriptionLong: String
        
        enum CodingKeys: String, CodingKey {
            case id, key, name
            case iconPath           = "icon"
            case descriptionShort   = "shortDesc"
            case descriptionLong    = "longDesc"
        }
    }
}
