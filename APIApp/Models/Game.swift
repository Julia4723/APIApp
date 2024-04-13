//
//  Game.swift
//  APIApp
//
//  Created by user on 08.04.2024.
//

import Foundation


// MARK: - Game
struct Game: Decodable {
    let sentence: String
    let character: Character
}

// MARK: - Character
struct Character: Decodable {
    let name, slug: String
    let house: House
}
  
// MARK: - House
struct House: Decodable {
    let name, slug: String
}
