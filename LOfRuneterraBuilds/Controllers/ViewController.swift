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
    var filteredCards: [Card]? = nil
    
    @IBOutlet weak var cardImageView: UIImageView!
    var changeCardsIndex: Int = 0
    
    @IBOutlet weak var cardsSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cardsSearchBar.delegate = self
        
        myServices.championLoadJson(filename: "set1-en_us") { (cards, error) in
            if error != nil { print(error) }
            else {
                self.allGameCards = cards
                
                DispatchQueue.main.async {
                    self.cardImageView.image = UIImage(named: cards![0].cardCode)
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

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            filteredCards = allGameCards
            
            myServices.filterForName(name: searchText, allCards: self.allGameCards!)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.cardsSearchBar.endEditing(true)
    }
}

