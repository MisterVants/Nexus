//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 28/02/20.
//

public struct ChampionRotationInfo: Codable {
    let freeChampionIds: [Int]
    let freeChampionIdsForNewPlayers: [Int]
    let maxNewPlayerLevel: Int
}
