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
    
    func configure(for deck: Deck) {
        playStyleLabel.text = deck.playStyle.rawValue
        nameLabel.text = deck.name
        
        //TODO: Add player name
        userLabel.text = "by: You"
    }
    
}
