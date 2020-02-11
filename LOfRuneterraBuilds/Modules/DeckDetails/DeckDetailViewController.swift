//
//  DeckDetailViewController.swift
//  LOfRuneterraBuilds
//
//  Created by Júlio John Tavares Ramos on 10/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class DeckDetailViewController: UIViewController {
    
    @IBOutlet weak var titleUIView: TitleCellUIView!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var cardsTableView: UITableView!
    
    var deck: Deck? = nil
    
    var tags: [String] = ["Burst", "Fast", "Capture", "Barrier"]
    
    var showDeck: ShowDeck? = nil
    
    //TODO: Delete this after doing the class
    var gameCards: [Card]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupCollectionView()
        
        if let deck = self.deck {
            titleUIView.titleLabel.text = deck.name
        }
        
        transformDeckInShowDeck()
    }
    
    func setupTableView() {
        self.cardsTableView.delegate = self
        self.cardsTableView.dataSource = self
    }
    
    func setupCollectionView() {
        self.tagCollectionView.delegate = self
        self.tagCollectionView.dataSource = self
    }

}

//TODO: Delete this after doing the class
extension DeckDetailViewController {
    
    func transformDeckInShowDeck() {
        var champion: [Pack] = []
        var spell: [Pack] = []
        var unit: [Pack] = []
        
        if let deck = self.deck {
            for pack in deck.cards {
                if pack.card.type.contains("Spell") {
                    spell.append(pack)
                } else if pack.card.type.contains("Unit") {
                    if pack.card.subtype.contains("Champion") {
                        champion.append(pack)
                    } else {
                        unit.append(pack)
                    }
                }
            }
        }
        
        self.showDeck = ShowDeck(champions: champion, spells: spell, followers: unit)
    }
}

extension DeckDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let deck = self.deck {
            return self.tags.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardTagCell", for: indexPath) as? DeckDetailTagCollectionViewCell
        
        if let cell = cell {
            cell.cardTag.text = self.tags[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension DeckDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        //One for each title (Monster, Spell, Unit)
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let deck = self.deck, let showDeck = self.showDeck {
            //Add 1 because title is a row, not a section
            if section == 0 {
                return showDeck.champions.count + 1
            } else if section == 1 {
                return showDeck.spells.count + 1
            } else {
                return showDeck.followers.count + 1
            }
        }
        //Has 3 titles in the worst case
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //If is the first row of each section, places the Title Cell
        let titleCell = self.cardsTableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? DeckDetailTitleTableViewCell
        if indexPath.row == 0, let titleCell = titleCell {
            if indexPath.section == 0 {
                titleCell.titleCell.text = "Champion"
            } else if indexPath.section == 1 {
                titleCell.titleCell.text = "Spell"
            } else {
                titleCell.titleCell.text = "Follower"
            }
            return titleCell
        }
        
        //For other rows, place Card cells
        let cell = self.cardsTableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as? CustomCardTableViewCell
        
        if let cell = cell, let deck = self.deck {
            let card = deck.cards[indexPath.row].card
            let pack = deck.cards[indexPath.row]
            
            //Fill infos
            cell.cardName.text = card.name
            cell.cardMana.text = "\(card.cost)"
            cell.cardsAmount.text = "\(pack.quantity)"
            cell.cardImage.backgroundColor = .black
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
