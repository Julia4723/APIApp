//
//  GameCell.swift
//  APIApp
//
//  Created by user on 11.04.2024.
//

import UIKit

final class GameCell : UITableViewCell {
    
    @IBOutlet var sentenceGame: UILabel!
    @IBOutlet var characterName: UILabel!
    @IBOutlet var houseName: UILabel!
    
    func configure(with game: Game) {
        sentenceGame.text = game.sentence
        characterName.text = game.character.name
        houseName.text = game.character.house.name
    }
    
}
