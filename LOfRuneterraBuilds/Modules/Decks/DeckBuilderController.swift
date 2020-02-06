//
//  DeckBuilderController.swift
//  LOfRuneterraBuilds
//
//  Created by Patricia Amado Ferreira de Mello on 06/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation
import UIKit

class DeckBuilderController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var myServices: LORService = LORService()
    var gameCards: [Card]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollection()
        setUpJSON()
    }
    
    
    func setUpCollection(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    func setUpJSON(){
        myServices.championLoadJson(filename: "set1-en_us") { (cards, error) in
            if error != nil {
                print(error)
                return
            }
            self.gameCards = cards
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

}




extension DeckBuilderController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let gameCards = self.gameCards {
            return (gameCards.count - 1)
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeckCollectionViewCell", for: indexPath) as! DeckCollectionViewCell
      return cell
    }
    
}
