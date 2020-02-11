//
//  DataUtils.swift
//  LOfRuneterraBuilds
//
//  Created by Guilherme Tavares Shimamoto on 11/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

enum DataUtils {
    case globals
    case set
    
    func getFileName() -> String {
        
        let currentLanguage = NSLocale.current.languageCode
        
        guard currentLanguage == "es" else {
            switch self {
            case .globals:
                return "globals-en_us"
            case .set:
                return "set1-en_us"
            }
        }
        
        switch self {
        case .globals:
            return "globals-es_es"
        case .set:
            return "set1-es_es"
        }
    }
}
