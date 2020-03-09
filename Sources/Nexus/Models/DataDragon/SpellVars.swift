//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 08/03/20.
//

public struct SpellVars: Codable {
    public let ranksWith: String?
    public let dyn: String?
    public let link: String
    public let coeff: CoeffType
    public let key: String
    
    public enum CoeffType: Codable {
        case number(Double)
        case array([Double])
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            
            if let double = try? container.decode(Double.self) {
                self = .number(double)
            } else {
                let array = try container.decode([Double].self)
                self = .array(array)
            }
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .number(let number): try container.encode(number)
            case .array(let array): try container.encode(array)
            }
        }
    }
}
