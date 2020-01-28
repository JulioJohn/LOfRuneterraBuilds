//
//  ViewController.swift
//  LOfRuneterraBuilds
//
//  Created by Júlio John Tavares Ramos on 28/01/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myServices: LORService = LORService()
    var allGameCards: [Card]? = nil
    
    @IBOutlet weak var cardImageView: UIImageView!
    var changeCardsIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myServices.championLoadJson(filename: "set1-en_us") { (cards, error) in
            if error != nil { print(error) }
            else {
                self.allGameCards = cards
                
                DispatchQueue.main.async {
                    
                }
            }
        }
        
    }
    
    
    @IBAction func changeCardsButton(_ sender: Any) {
        if let gameCards = self.allGameCards {
            self.cardImageView.image = UIImage(named: "\(gameCards[changeCardsIndex].cardCode)") 
            self.changeCardsIndex += 1
        } else {
            print("Não tem cartas")
        }
    }
}

