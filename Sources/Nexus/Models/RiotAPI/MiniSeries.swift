//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 02/03/20.
//

public struct MiniSeries: Codable {
    
    /// A string representing the progress of the current promotional mini series.
    let progress: String
    
    /// How many wins are needed for a promotion.
    let target: Int
    
    /// The current number of wins during this mini series
    let wins: Int
    
    /// The current number of losses during this mini series
    let losses: Int
}
