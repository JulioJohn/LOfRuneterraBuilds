//
//  LORService.swift
//  LOfRuneterraBuilds
//
//  Created by Júlio John Tavares Ramos on 28/01/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class LORService {
    
    var DAO = LORDAO()
    
    func championLoadJson(filename fileName: String, completion: @escaping ([Card]?, Error?) -> Void) {
        self.DAO.championLoadJson(filename: fileName) { (cards, error) in
            completion(cards, error)
        }
    }
    
    func infosLoadJson(filename fileName: String, completion: @escaping (CardInfo?, Error?) -> Void) {
        self.DAO.infosLoadJson(filename: fileName) { (cards, error) in
            completion(cards, error)
        }
    }
}
