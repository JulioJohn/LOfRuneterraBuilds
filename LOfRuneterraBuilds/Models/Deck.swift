//
//  Deck.swift
//  LOfRuneterraBuilds
//
//  Created by Guilherme Tavares Shimamoto on 05/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

struct Deck {
    var author: String?
    var cards: [Card] = []
    var name: String
    var factions: [Faction]
    var playStyle: PlayStyle
    var description: String?
}
