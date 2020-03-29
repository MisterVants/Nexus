//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 29/02/20.
//

public enum Region: String, CaseIterable {
    case br
    case eune
    case euw
    case jp
    case kr
    case lan
    case las
    case na
    case oce
    case tr
    case ru
    case pbe
}

extension Region {
    
    public init?(tag: String) {
        switch tag {
        case "br", "br1", "pt_BR":       self = .br
        case "eune", "eun1":    self = .eune
        case "euw", "euw1":     self = .euw
        case "jp", "jp1":       self = .jp
        case "kr":              self = .kr
        case "lan", "la1":      self = .lan
        case "las", "la2":      self = .las
        case "na", "na1", "en_US":       self = .na
        case "oce", "oc1":      self = .oce
        case "tr", "tr1":       self = .tr
        case "ru":              self = .ru
        case "pbe", "pbe1":     self = .pbe
        default: return nil
        }
    }
    
    public var platform: String {
        switch self {
        case .br:   return "br1"
        case .eune: return "eun1"
        case .euw:  return "euw1"
        case .jp:   return "jp1"
        case .kr:   return "kr"
        case .lan:  return "la1"
        case .las:  return "la2"
        case .na:   return "na1"
        case .oce:  return "oc1"
        case .tr:   return "tr1"
        case .ru:   return "ru"
        case .pbe:  return "pbe1"
        }
    }
}
