//
//  CardSelectController.swift
//  LOfRuneterraBuilds
//
//  Created by Patricia Amado Ferreira de Mello on 05/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

protocol CardSelectDelegate: class {
    func addCard(for card: Card)
    func removeCard(for card: Card)
    func goToCardDetails(for card: Card)
}

class CardSelectController: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var cardsAmount: UILabel!
    
    weak var delegate: CardSelectDelegate?
    
    //TODO: add card
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
        Bundle.main.loadNibNamed("CardSelect", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    
    /// Change actual cards and update the imageView
    /// - Parameter card: Card
    func changeCard(card: Card) {
        self.card = card
        self.cardSetUp()
    }
    
    func cardSetUp(){
        if let cardImageName = self.card?.cardCode {
            self.cardImage.image = UIImage(named: cardImageName)
        }
    }
    
    @IBAction func removeCard(_ sender: Any) {
        delegate?.removeCard(for: card!)
    }
    
    @IBAction func addCard(_ sender: Any) {
        delegate?.addCard(for: card!)
    }
    
    @IBAction func goToCardDetail(_ sender: UIButton) {
        delegate?.goToCardDetails(for: card!)
    }
    
    func hideCardAmountButtons() {
        cardsAmount.isHidden = true
        increaseButton.isHidden = true
        decreaseButton.isHidden = true
    }
}
