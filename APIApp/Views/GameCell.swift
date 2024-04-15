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
    

    func configure(game: Game) {
        sentenceGame.text = game.sentence
        characterName.text = "Hero: \(game.character.name)"
        houseName.text = "House: \(game.character.house.name)"
        }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    }

