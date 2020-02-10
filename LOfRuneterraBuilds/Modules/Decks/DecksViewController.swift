//
//  DecksViewController.swift
//  LOfRuneterraBuilds
//
//  Created by Guilherme Tavares Shimamoto on 05/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation
import UIKit

class DeckViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleView: TitleCellUIView!
    
    var selectedDeckIndex: Int? = nil
    
    var decks: [Deck] = {
        let d1 = Deck(author: "You", name: "Teste 1", factions: [.demacia, .freljord], playStyle: .midrange)
        
        let d2 = Deck(author: "You", name: "Teste 2", factions: [.demacia, .freljord], playStyle: .aggro)
        
        let d3 = Deck(author: "You", name: "Teste 3", factions: [.demacia, .ionia], playStyle: .aggro)

        let d4 = Deck(author: "You", name: "Teste 4", factions: [.demacia, .noxus], playStyle: .aggro)

        let d5 = Deck(author: "You", name: "Teste 5", factions: [.demacia, .piltoverAndZaun], playStyle: .aggro)

        let d6 = Deck(author: "You", name: "Teste 6", factions: [.demacia, .shadowIsles], playStyle: .aggro)

        return [d1, d2, d3, d4, d5, d6]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.titleLabel.text = "My Decks"
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
    @objc func buttonAction(_ sender: UIButton!) {
        performSegue(withIdentifier: "goToDeckBuilder", sender: nil)
    }
}

extension DeckViewController: UITableViewDelegate {
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

extension DeckViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        
        let button = UIButton()
        button.setTitle("Build New Deck", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor(red: 189/255, green: 148/255, blue: 91/255, alpha: 1)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        customView.addSubview(button)
        
        //Adding constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: customView.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: customView.bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -20).isActive = true
        button.layer.cornerRadius = 6
        
        return customView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "deckCell", for: indexPath) as? DeckCell  else { return UITableViewCell() }
        
        cell.configure(for: decks[indexPath.row])
        return cell
    }
}
