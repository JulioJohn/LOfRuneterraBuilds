//
//  Faction.swift
//  LOfRuneterraBuilds
//
//  Created by Guilherme Tavares Shimamoto on 05/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation
import UIKit

enum Faction: String {
    case demacia = "Demacia"
    case freljord = "Freljord"
    case ionia = "Ionia"
    case noxus = "Noxus"
    case piltoverAndZaun = "PiltoverZaun"
    case shadowIsles = "ShadowIsles"
    
    func code() -> String {
        switch self {
        case .demacia:
            return "DE"
        case .freljord:
            return "FR"
        case .ionia:
            return "IO"
        case .noxus:
            return "NX"
        case .piltoverAndZaun:
            return "PZ"
        case .shadowIsles:
            return "SI"
        }
    }
    
    func getImage() -> UIImage? {
        switch self {
        case .demacia:
            return UIImage(named: "icon-demacia")
        case .freljord:
            return UIImage(named: "icon-freljord")
        case .ionia:
            return UIImage(named: "icon-ionia")
        case .noxus:
            return UIImage(named: "icon-noxus")
        case .piltoverAndZaun:
            return UIImage(named: "icon-piltoverzaun")
        case .shadowIsles:
            return UIImage(named: "icon-shadowisles")
        }
    }
    
}
