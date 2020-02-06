//
//  LORDAO.swift
//  LOfRuneterraBuilds
//
//  Created by Júlio John Tavares Ramos on 28/01/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class LORDAO {
    func championLoadJson(filename fileName: String, completion: @escaping ([Card]?, Error?) -> Void) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Card].self, from: data)
                completion(jsonData, nil)
            } catch {
                completion(nil, ServerError.jsonCantBeLoaded)
            }
        }
    }
    
    func infosLoadJson(filename fileName: String, completion: @escaping (CardInfo?, Error?) -> Void) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(CardInfo.self, from: data)
                completion(jsonData, nil)
            } catch {
                completion(nil, ServerError.jsonCantBeLoaded)
            }
        }
    }
}
