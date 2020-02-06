//
//  Filter.swift
//  LOfRuneterraBuilds
//
//  Created by Júlio John Tavares Ramos on 05/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class Filter {
    var name: String?
    var region: String?
    var cost: Int?
    
    init(name: String?, regions: String?, cost: Int?) {
        self.name = name
        self.region = regions
        self.cost = cost
    }
    
    func filterForName(allCards: [Card]) -> [Card]? {
        var filteredCards = allCards.filter({ (card) -> Bool in
            
            if let name = self.name {
                guard card.name.contains(name) else { return false }
            }
            
            if let region = self.region {
                guard card.region.contains(region) else { return false }
            }
        
            if let cost = self.cost {
                guard card.cost == cost else { return false }
            }
            
            return true
        })
        
        print("Array filtrado com sucesso!")
        print(filteredCards.count)
        
        return filteredCards
    }
}
