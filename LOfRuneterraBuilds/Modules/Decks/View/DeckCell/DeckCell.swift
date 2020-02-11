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
    
    @IBOutlet weak var playStyleLabel: UILabel! {
        didSet {
            playStyleLabel.font = UIFont.scaledFont(for: "OpenSans-Regular", size: 11)
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = UIFont.scaledFont(for: "Oswald-Regular", size: 17)
        }
    }
    
    @IBOutlet weak var userLabel: UILabel! {
        didSet {
            userLabel.font = UIFont.scaledFont(for: "OpenSans-Regular", size: 11)
        }
    }
    
    @IBOutlet weak var firstFaction: UIImageView!
    
    @IBOutlet weak var secondFaction: UIImageView!
    
    func configure(for deck: Deck) {
        playStyleLabel.text = deck.playStyle.rawValue
        nameLabel.text = deck.name
        
        setupUserLabel(for: deck)
        setupFactionImages(for: deck)
    }
    
    func setupUserLabel(for deck: Deck) {
        if let author = deck.author {
            let authorText = String(format: NSLocalizedString("by User", comment: ""), "\(author)")
            
            let boldFont = UIFont.scaledFont(for: "OpenSans-Bold", size: 11)
            let boldRange = NSString(string: authorText).range(of: "\(author)")
            
            let myMutableString = NSMutableAttributedString(string: authorText)
            myMutableString.addAttribute(.font, value: boldFont, range: boldRange)
            userLabel.attributedText = myMutableString
        } else {
            userLabel.isHidden = true
        }
    }
    
    func setupFactionImages(for deck: Deck) {
        if deck.factions.count == 1 {
            guard let image = deck.factions[0].getImage() else { return }
            secondFaction.isHidden = true
            
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
