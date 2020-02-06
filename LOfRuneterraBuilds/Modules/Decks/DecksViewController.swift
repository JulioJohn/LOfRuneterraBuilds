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
    
    var decks: [Deck] = {
        let d1 = Deck(name: "Teste 1", factions: [.demacia], playStyle: .aggro)
        
        let d2 = Deck(name: "Teste 2", factions: [.demacia, .freljord], playStyle: .aggro)
        
        return [d1, d2]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        let nib = UINib.init(nibName: "DeckCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "deckCell")
        
        createTableViewFooter()
    }
    
    func createTableViewFooter() {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        
        let button = UIButton()
        button.setTitle("Create New Deck", for: .normal)
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

        tableView.tableFooterView = customView
    }
    
    @objc func buttonAction(_ sender: UIButton!) {
        print("Button tapped")
    }
}

extension DeckViewController: UITableViewDelegate {
    
}

extension DeckViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "deckCell", for: indexPath) as? DeckCell  else { return UITableViewCell() }
        
        cell.configure(for: decks[indexPath.row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
}
