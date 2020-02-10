//
//  DeckCell.swift
//  LOfRuneterraBuilds
//
//  Created by Guilherme Tavares Shimamoto on 05/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation
import UIKit

class DeckCell: UITableViewCell {

    @IBOutlet weak var playStyleLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var firstFaction: UIImageView!
    
    @IBOutlet weak var secondFaction: UIImageView!
    
    func configure(for deck: Deck) {
        playStyleLabel.text = deck.playStyle.rawValue
        nameLabel.text = deck.name
        
        //TODO: Add player name
        userLabel.text = "by: You"
        
        
        if deck.factions.count == 1 {
            secondFaction.isHidden = true
            
            guard let image = deck.factions[0].getImage() else { return }
            firstFaction.image = image
            firstFaction.contentMode = .scaleAspectFill
        } else {
            guard let firstImage = deck.factions[0].getImage(),
                let secondImage = deck.factions[1].getImage() else { return }
            firstFaction.image = firstImage
            firstFaction.contentMode = .scaleAspectFill
            
            secondFaction.image = secondImage
            secondFaction.contentMode = .scaleAspectFill
        }
    }
}
