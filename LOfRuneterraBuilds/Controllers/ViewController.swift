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
    
    var changeCardsIndex: Int = 0
    
    
    @IBOutlet weak var cardImageView: UIImageView!
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCardDetails" {
            if let vc = segue.destination as? CardDetailsViewController {
                vc.card = allGameCards![0]
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            filteredCards = allGameCards
            
            filteredCards = Filter(name: searchText, regions: nil, cost: 3).filterForName(allCards: allGameCards!)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.cardsSearchBar.endEditing(true)
    }
}

