//
//  CustomCardTableViewCell.swift
//  LOfRuneterraBuilds
//
//  Created by Patricia Amado Ferreira de Mello on 10/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class CustomCardTableViewCell: UITableViewCell {
    
    @IBOutlet var content: UIView!
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardMana: UILabel!
    
    @IBOutlet weak var cardsAmount: UILabel!
    
    var pack: Pack? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    func commonInit(){
        Bundle.main.loadNibNamed("CustomCard", owner: self, options: nil)
        addSubview(self.content)
        self.content.frame = self.bounds
        self.content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func cardSetUp(){
        if let cardImageName = self.pack?.card.cardCode {
            self.cardImage.image = UIImage(named: cardImageName)
        }
        
        if let cardName = self.pack?.card.name {
            self.cardName.text = cardName
        }
        
        if let cardMana = self.pack?.card.cost {
            self.cardMana.text = "\(cardMana)"
        }
    }

}
