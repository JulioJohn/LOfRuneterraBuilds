//
//  GalleryViewController.swift
//  LOfRuneterraBuilds
//
//  Created by Guilherme Tavares Shimamoto on 11/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation
import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var titleView: TitleCellUIView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var selectedFiltersView: UIView!
    
    @IBOutlet weak var filterCountLabel: UILabel!
    
    var myServices: LORService = LORService()
    var gameCards: [Card]? = nil
    var selectedCard: Card? = nil
    var filteredCards: [Card]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.titleLabel.text = NSLocalizedString("Card Gallery", comment: "")
        
        let screenTitle = NSLocalizedString("Gallery", comment: "")
        
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
    
    func setUpSearchBar() {
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.white
        }
    }
    
    func setUpFilterPin(){
        makeCirle(view: self.selectedFiltersView)
        self.selectedFiltersView.isHidden = true
        self.filterCountLabel.isHidden = true
    }
    
    @IBAction func cartButton(_ sender: UIButton) {
        //TODO: segue to CardEditing
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCardDetails" {
            if let vc = segue.destination as? CardDetailsViewController {
                if let selectedCard = self.selectedCard {
                    vc.card = selectedCard
                    vc.shouldShowCardButtons = false
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

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
            cell.cardSelect.pack?.card = gameCards[indexPath.row]
            cell.cardSelect.cardSetUp()
            cell.cardSelect.hideCardAmountButtons()
        }
        cell.cardSelect.delegate = self
        
        return cell
    }
}

extension GalleryViewController: CardSelectDelegate {
    func goToCardDetails(for pack: Pack) {
        self.selectedCard = pack.card
        performSegue(withIdentifier: "goToCardDetails", sender: nil)
    }
    
    func addCard(for pack: Pack) {}
    
    func removeCard(for pack: Pack) {}
}

extension GalleryViewController: UISearchBarDelegate {
    
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
