//
//  CustomCardUIView.swift
//  LOfRuneterraBuilds
//
//  Created by Patricia Amado Ferreira de Mello on 10/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class CustomCardUIView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardMana: UILabel!
    
    @IBOutlet weak var cardAmount: UILabel!
    
    var card: Card? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("CustomCard", owner: self, options: nil)
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func cardSetUp(){
        if let cardImageName = self.card?.cardCode {
            self.cardImage.image = UIImage(named: cardImageName)
        }
        
        if let cardName = self.card?.name {
            self.cardName.text = cardName
        }
        
        if let cardMana = self.card?.cost {
            self.cardMana.text = "\(cardMana)"
        }
    }
    
}
