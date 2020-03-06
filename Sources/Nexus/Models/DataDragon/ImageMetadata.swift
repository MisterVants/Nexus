//
//  ImageMetadata.swift
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

import CoreGraphics

/**
 A structure that references an image sprite in Data Dragon.
 
 An image sprite resource can be retrieved in two ways: By using the
 direct URL for a given resource or by retrieving its sprite sheet
 and locating the sprite by its frame.
 
 To request a sprite by its URL, you need to specify its group and
 filename as path components in a versioned image URL. The URL should
 be constructed as following:
 
 ````
 ddragon.leagueoflegends.com/cdn/{patch}/img/{group}/{filename}
 ````
 
 A sprite sheet can be retrived with the same URL scheme, located under
 the 'sprite' group and using the sprite sheet's name as the filename.
 The frame property should then be used to locate the sprite in the sheet.
 
 If you need to retrieve a large ammount of sprites, the second approach
 works best, as a single network call will retrieve multiple sprites of a
 category in a batch.
 */
public struct ImageMetadata: Codable {
    
    /// The identifier string describing the group of the referenced image.
    public let group: String
    
    /// The identifier string describing the resource name of the referenced image.
    public var filename: String { return full }
    private let full: String
    
    /// The identifier string describing the filename of the sprite sheet that contains the referenced image.
    public var spriteSheet: String { return sprite }
    private let sprite: String
    
    /// A rectangle describing the sprite location and size in its referenced sprite sheet.
    public var frame: CGRect {
        return CGRect(x: x, y: y, width: w, height: h)
    }
    private let x: Int
    private let y: Int
    private let w: Int
    private let h: Int
}
