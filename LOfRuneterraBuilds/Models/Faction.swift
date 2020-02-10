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
    case demacia = "DE"
    case freljord = "FR"
    case ionia = "IO"
    case noxus = "NX"
    case piltoverAndZaun = "PZ"
    case shadowIsles = "SI"
    
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
