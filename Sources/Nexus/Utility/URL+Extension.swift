//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 02/03/20.
//

import Foundation

extension URL {
    
    func appendingPathComponents(_ pathComponents: String...) -> URL {
        return pathComponents.reduce(self) { url, pathComponent -> URL in
            url.appendingPathComponent(pathComponent)
        }
    }
    
    func appendingPathComponent<T: RawRepresentable>(_ component: T) -> URL where T.RawValue == String {
        appendingPathComponent(component.rawValue)
    }
}

extension URL {
    
    func json() -> URL {
        return self.pathExtension.isEmpty ? self.appendingPathExtension("json") : self
    }
    
    func png() -> URL {
        return self.pathExtension.isEmpty ? self.appendingPathExtension("png") : self
    }
    
    func jpg() -> URL {
        return self.pathExtension.isEmpty ? self.appendingPathExtension("jpg") : self
    }
}
