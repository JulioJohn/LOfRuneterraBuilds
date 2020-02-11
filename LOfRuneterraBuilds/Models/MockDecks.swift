//
//  MockDecks.swift
//  LOfRuneterraBuilds
//
//  Created by Júlio John Tavares Ramos on 11/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class MockDecks {
    var allGameCards: [Card]
    
    init(gameCards: [Card]) {
        self.allGameCards = gameCards
    }
    
    func makeFakeDeck() -> Deck {
        let packs: [Pack] = [getPacksOfCards(cardName: "Anivia", quantity: 2),
        getPacksOfCards(cardName: "Vile Feast", quantity: 1),
        getPacksOfCards(cardName: "Vengeance", quantity: 3),
        getPacksOfCards(cardName: "She Who Wanders", quantity: 2)]
        
        let deck = Deck(author: "Julio John", cards: packs, name: "Budget Control", factions: [.shadowIsles,.freljord], playStyle: .control, description: "")
        return deck
    }
    
    func anotherFakeDeck() -> Deck {
        let packs: [Pack] = [getPacksOfCards(cardName: "Anivia", quantity: 2),
        getPacksOfCards(cardName: "Vile Feast", quantity: 1),
        getPacksOfCards(cardName: "Vengeance", quantity: 3),
        getPacksOfCards(cardName: "She Who Wanders", quantity: 2)]
        
        let deck = Deck(author: "Julio John", cards: packs, name: "Swim's Dawnspiders", factions: [.shadowIsles,.demacia], playStyle: .control, description: "")
        return deck
    }
    
    func getPacksOfCards(cardName: String, quantity: Int) -> Pack {
        let card = getCardsFromDeck(cardName: cardName)
        let pack = Pack(card: card!, quantity: quantity)
        return pack
    }
    
    func getCardsFromDeck(cardName: String) -> Card? {
        for card in allGameCards {
            if card.name.contains(cardName) {
                print(card.name)
                return card
            }
        }
        return nil
    }
}
