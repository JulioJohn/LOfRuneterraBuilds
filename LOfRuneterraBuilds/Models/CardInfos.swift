//
//  CardInfos.swift
//  LOfRuneterraBuilds
//
//  Created by Júlio John Tavares Ramos on 06/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

struct CardInfo: Decodable {
    var keywords: [Keywords]
    var regions: [Regions]
    var spellSpeeds: [SpellSpeeds]
    var rarities: [Rarities]
    
    func searchForHabilityDescription(hability: String) -> String {
        for keyword in keywords {
            if keyword.nameRef.contains(hability) {
                return keyword.description
            }
        }
        return ""
    }
}

struct Keywords: Decodable {
    var description: String
    var name: String
    var nameRef: String
}

struct Regions: Decodable {
    var abbreviation: String
    var iconAbsolutePath: String
    var name: String
    var nameRef: String
}

struct SpellSpeeds: Decodable {
    var name: String
    var nameRef: String
}

struct Rarities: Decodable {
    var name: String
    var nameRef: String
}
