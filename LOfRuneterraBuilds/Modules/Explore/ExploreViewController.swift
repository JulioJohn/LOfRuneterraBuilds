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
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleView: TitleCellUIView!
    
    var selectedDeckIndex: Int? = nil
    
    var decks: [Deck] = {
        let d1 = Deck(author: "Username",
                      name: "Warmother Control",
                      factions: [.demacia, .freljord],
                      playStyle: .midrange)
        
        let d2 = Deck(author: "Username",
                      name: "Warmother Control",
                      factions: [.demacia, .freljord],
                      playStyle: .midrange)
        
        let d3 = Deck(author: "Username",
                      name: "Warmother Control",
                      factions: [.demacia, .freljord],
                      playStyle: .midrange)
        
        return [d1, d2, d3]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.titleLabel.text = "Explore the Best Decks"
        setupTableView()
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
