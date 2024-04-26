//
//  Game.swift
//  APIApp
//
//  Created by user on 08.04.2024.
//



// MARK: - Game
struct Game: Codable {
    let sentence: String
    var character: Character
  
    init(quoteData: [String: Any]) {
        sentence = quoteData["sentence"] as? String ?? ""
        
        let characterDict = quoteData["character"] as? [String: Any] ?? [:]
        character = Character(quoteData: characterDict)
        
        
    }
    

    static func getQuotes(from jsonValue: Any) -> [Game] {
        guard let quoteData = jsonValue as? [[String: Any]] else { return []}
        //guard let games = value as? [[String: Any]] else { return []}
        //guard let characters = value as? [String: Any] else { return []}
        
        return quoteData.map { Game(quoteData: $0)}
    }
    
}
        
    
    
    
    
    // MARK: - Character
struct Character: Codable {
    let name, slug: String
    var house: House
    
    init(quoteData: [String: Any]) {
        name = quoteData["name"] as? String ?? ""
        slug = quoteData["slug"] as? String ?? ""
        let houseDict = quoteData["house"] as? [String: Any] ?? [:]
        house = House(quoteData:houseDict)
        
    }
    
}


    // MARK: - House
struct House: Codable {
    let name, slug: String
    
    init(quoteData: [String: Any]) {
        name = quoteData["name"] as? String ?? ""
        slug = quoteData["slug"] as? String ?? ""
    }

}
    
    
    /* Ручное сопоставление данных JSON
     enum CodingKeys: String, CodingKey {
     case sentence = "sentence"
     }
     } */

