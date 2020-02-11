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
    @IBOutlet weak var selectedFilters: UIView!
    @IBOutlet weak var labelFilter: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleView: TitleCellUIView!
    
    @IBOutlet weak var cardsAmount: UILabel! {
        didSet {
            cardsAmount.font = UIFont.scaledFont(for: "OpenSans-SemiBold", size: 17)
            cardsAmount.adjustsFontSizeToFitWidth = true
        }
    }

    @IBOutlet weak var buttonLabel: UILabel! {
        didSet {
            buttonLabel.text = NSLocalizedString("Show My Deck", comment: "")
            buttonLabel.font = UIFont.scaledFont(for: "OpenSans-SemiBold", size: 17)
            buttonLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    var myServices: LORService = LORService()
    var gameCards: [Card]? = nil
    var selectedCard: Card? = nil
    var filteredCards: [Card]? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.titleLabel.text = NSLocalizedString("Choose Your Cards", comment: "")
        
        let screenTitle = NSLocalizedString("Choose Cards", comment: "")
        
        let backItem = UIBarButtonItem()
        backItem.title = screenTitle
        
        self.title = screenTitle
        self.navigationItem.backBarButtonItem = backItem
        
        setUp()
    }
    
    
    func setUp() {
        setUpCollection()
        setUpJSON()
        setUpFilterPin()
        setUpSearchBar()
        setupToHideKeyboardOnTapOnView()
    }
    
    func setUpCollection() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.searchBar.delegate = self
    }
    
    func setUpJSON() {
        myServices.championLoadJson(filename: DataUtils.set.getFileName()) { (cards, error) in
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
    
    //TODO: Change the textfield.background color to the app background color
    func setUpSearchBar(){
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.white
            textfield.backgroundColor = UIColor.darkGray
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
        if segue.identifier == "goToDeckCart" {
            if let vc = segue.destination as? DeckCartController {
                if let card = self.gameCards {
                    vc.cards = card
                }
            }
        }
    }
    
    
    func makeCirle(view: UIView){
        view.layer.cornerRadius = view.frame.size.width/2
        view.clipsToBounds = true
    }
    
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
        filteredCards = self.gameCards

        if searchText.isEmpty == false {
            let filter = Filter(name: searchText, regions: nil, cost: nil)
            filteredCards = filter.filterForName(allCards: gameCards!)
        }
        
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
