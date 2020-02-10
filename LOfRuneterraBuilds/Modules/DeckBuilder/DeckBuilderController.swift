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
    @IBOutlet weak var selectedFilters: UIView!
    @IBOutlet weak var labelFilter: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var myServices: LORService = LORService()
    var gameCards: [Card]? = nil
    var selectedCard: Card? = nil
    var filteredCards: [Card]? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    
    func setUp(){
        setUpCollection()
        setUpJSON()
        setUpFilterPin()
    }
    
    
    func setUpCollection(){
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.searchBar.delegate = self
    }
    
    
    func setUpJSON(){
        myServices.championLoadJson(filename: "set1-en_us") { (cards, error) in
            if error != nil {
                print(error)
                return
            }
            self.gameCards = cards
            self.filteredCards = self.gameCards
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    func setUpFilterPin(){
        makeCirle(view: self.selectedFilters)
        self.selectedFilters.isHidden = true
        self.labelFilter.isHidden = true
    }
    
    
    @IBAction func cartButton(_ sender: UIButton) {
        //TODO: segue to CardEditing
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
    
    
    func makeCirle(view: UIView){
        view.layer.cornerRadius = view.frame.size.width/2
        view.clipsToBounds = true
    }
}



extension DeckBuilderController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let amount = self.filteredCards {
            return (amount.count / 2) - 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deckBuilderCell", for: indexPath) as! DeckCollectionViewCell
        if let gameCards = self.filteredCards {
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


extension DeckBuilderController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            self.filteredCards = self.gameCards
            
            self.filteredCards = Filter(name: searchText, regions: nil, cost: nil).filterForName(allCards: gameCards!)
            
            self.collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
