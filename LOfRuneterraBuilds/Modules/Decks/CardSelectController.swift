//
//  CardSelectController.swift
//  LOfRuneterraBuilds
//
//  Created by Patricia Amado Ferreira de Mello on 05/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class CardSelectController: UIView {
    
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var cardsAmount: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit(){
        makeCirle(button: increaseButton)
        makeCirle(button: decreaseButton)
    }
    
    
    func makeCirle(button: UIButton){
        button.layer.cornerRadius = button.frame.size.width/2
        button.clipsToBounds = true
    }

}
