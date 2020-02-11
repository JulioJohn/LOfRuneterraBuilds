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
    
    var showDeck = ShowDeck(champions: nil, spells: nil, followers: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupCollectionView()
        
        if let deck = self.deck {
            titleUIView.titleLabel.text = deck.name
        }
    }
    
    func setupTableView() {
        self.cardsTableView.delegate = self
        self.cardsTableView.delegate = self
    }
    
    func setupCollectionView() {
        self.tagCollectionView.delegate = self
        self.tagCollectionView.dataSource = self
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let deck = self.deck {
            return deck.cards.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.cardsTableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
        
        return cell
    }
    
    
}
