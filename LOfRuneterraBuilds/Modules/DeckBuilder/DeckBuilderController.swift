//
//  DeckBuilderController.swift
//  LOfRuneterraBuilds
//
//  Created by Patricia Amado Ferreira de Mello on 06/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

//para fazer markup do codigo usar "option + command + /"

import Foundation
import UIKit

class DeckBuilderController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cardsAmount: UILabel!
    
    
    var myServices: LORService = LORService()
    var gameCards: [Card]? = nil
    
    var selectedCard: Card? = nil
    
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
    
    @IBAction func cartButton(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCardDetails" {
            if let vc = segue.destination as? CardDetailsViewController {
                if let selectedCard = self.selectedCard {
                    vc.card = selectedCard
                }
            }
        }
    }
    
}




extension DeckBuilderController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let amount = self.gameCards {
            return (amount.count / 2) - 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deckBuilderCell", for: indexPath) as! DeckCollectionViewCell
        if let gameCards = self.gameCards {
            cell.cardSelect.card = gameCards[indexPath.row]
            cell.cardSelect.cardSetUp()
        }
        
        cell.cardSelect.delegate = self
        
        return cell
    }
}


extension DeckBuilderController: CardSelectDelegate {
    func goToCardDetails(for card: Card) {
        self.selectedCard = card
        performSegue(withIdentifier: "goToCardDetails", sender: nil)
    }

    func addCard(for card: Card) {
        print("Adicionou!!!")
    }
    
    func removeCard(for card: Card) {
        print("Removeu!!!")
    }
}
