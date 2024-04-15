//
//  Game.swift
//  APIApp
//
//  Created by user on 08.04.2024.
//

import Foundation


// MARK: - Game
struct Game: Codable {
    let sentence: String
    let character: Character
}
    
    
    // MARK: - Character
    struct Character: Codable {
        let name, slug: String
        let house: House
    }
    
    // MARK: - House
    struct House: Codable {
        let name, slug: String
    }



/* Ручное сопоставление данных JSON
 enum CodingKeys: String, CodingKey {
 case sentence = "sentence"
 }
 } */
