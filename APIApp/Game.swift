//
//  Game.swift
//  APIApp
//
//  Created by user on 08.04.2024.
//

import Foundation

struct Game: Decodable {
    let sentence: String
        struct character: Decodable {
            let name: String
            let slug: String
            struct house: Decodable {
                let name: String
                let slug: String
            }
        }
    }
