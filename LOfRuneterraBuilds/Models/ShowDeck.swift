//
//  ShowDeck.swift
//  LOfRuneterraBuilds
//
//  Created by Júlio John Tavares Ramos on 11/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class ShowDeck {
    var champions: [Pack] = []
    var spells: [Pack] = []
    var followers: [Pack] = []
    
    init(champions: [Pack], spells: [Pack], followers: [Pack]) {
        self.champions = champions
        self.spells = spells
        self.followers = followers
    }
}
