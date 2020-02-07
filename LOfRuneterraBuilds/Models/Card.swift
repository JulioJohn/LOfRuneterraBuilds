//
//  Card.swift
//  LOfRuneterraBuilds
//
//  Created by Júlio John Tavares Ramos on 28/01/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

struct Card: Decodable {
    var associatedCards: [String]
    var associatedCardRefs: [String]
    var assets: [AssetsDetails]
    var region: String
    var regionRef: String
    var attack: Double
    var cost: Int
    var health: Int
    var description: String
    var descriptionRaw: String
    var levelupDescription: String
    var levelupDescriptionRaw: String
    var flavorText: String
    var artistName: String
    var name: String
    var cardCode: String
    var keywords: [String]
    var keywordRefs: [String]
    var spellSpeed: String
    var spellSpeedRef: String
    var rarity: String
    var rarityRef: String
    var subtype: String
    var type: String
    var collectible: Bool
    
    func descriptionWithoutXML() -> String{
        var newDescription = ""
        var betweenKey: Bool = false
        
        for character in description {
            if character == "<" {
                betweenKey = true
            }
            
            if betweenKey == false {
                newDescription.append(character)
            }
            
            if character == ">" {
                betweenKey = false
            }
        }
        
        return newDescription
    }
}

struct AssetsDetails: Decodable {
    var gameAbsolutePath: String
    var fullAbsolutePath: String
}
