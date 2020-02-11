//
//  ExploreViewController.swift
//  LOfRuneterraBuilds
//
//  Created by Guilherme Tavares Shimamoto on 10/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation
import UIKit

class ExploreViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleView: TitleCellUIView!
    
    //Other
    var selectedDeckIndex: Int? = nil
    
    //Datas
    var allGameCards: [Card]? = nil
    var mockDeckClass: MockDecks? = nil
    var decks: [Deck] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("Explore", comment: "")
        titleView.titleLabel.text = NSLocalizedString("Explore the Best Decks", comment: "")
        setupTableView()
        
        //TODO: Remove when capturing decks from cloud
        setUpJSON()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        let nib = UINib.init(nibName: "DeckCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "deckCell")
        
        tableView.backgroundColor = UIColor(displayP3Red: 42/255, green: 38/255, blue: 42/255, alpha: 1)
    }
}

//
extension ExploreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedDeckIndex = indexPath.row
        performSegue(withIdentifier: "goToDeckDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDeckDetail" {
            if let vc = segue.destination as? DeckDetailViewController, let index = self.selectedDeckIndex {
                vc.deck = decks[index]
            }
        }
    }
}

//
extension ExploreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "deckCell", for: indexPath) as? DeckCell  else { return UITableViewCell() }
        
        cell.configure(for: decks[indexPath.row])
        return cell
    }
}

extension ExploreViewController {
    func setUpJSON() {
        let service = LORService()
        
        service.championLoadJson(filename: DataUtils.set.getFileName()) { (cards, error) in
            if error != nil {
                print(error)
                return
            }
            //Get all cards from game
            self.allGameCards = cards
            
            //Create mock deck class
            let mockDeckClass = MockDecks(gameCards: cards!)
            
            //Fill decks with mocked decks
            self.decks = [mockDeckClass.makeFakeDeck(), mockDeckClass.anotherFakeDeck()]
            
            //Update screen
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
}
