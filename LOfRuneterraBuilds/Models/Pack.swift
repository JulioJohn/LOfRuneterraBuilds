//
//  Pack.swift
//  LOfRuneterraBuilds
//
//  Created by Júlio John Tavares Ramos on 10/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class Pack {
    var card: Card
    var quantity: Int
    
    init(card: Card, quantity: Int) {
        self.card = card
        self.quantity = quantity
    }
}
