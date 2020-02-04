//
//  LORService.swift
//  LOfRuneterraBuilds
//
//  Created by Júlio John Tavares Ramos on 28/01/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class LORService {
    
    var DAO = LORDAO()
    
    func championLoadJson(filename fileName: String, completion: @escaping ([Card]?, Error?) -> Void) {
        self.DAO.championLoadJson(filename: fileName) { (cards, error) in
            completion(cards, error)
        }
    }
    
    func filterForName(name: String, allCards: [Card]) -> [Card]? {
        var filteredCards = allCards.filter({ (card) -> Bool in
            if card.name.contains(name) {
                //cardImageView.image = UIImage(named: card.cardCode)
                return true
            } else {
                return false
            }
        })
        
        print("Array filtrado com sucesso!")
        
        return filteredCards
    }
}
