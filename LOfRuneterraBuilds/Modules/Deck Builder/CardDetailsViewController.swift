//
//  CardDetailsViewController.swift
//  LOfRuneterraBuilds
//
//  Created by Júlio John Tavares Ramos on 05/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class CardDetailsViewController: UIViewController {
    
    @IBOutlet weak var regionText: UILabel!
    @IBOutlet weak var monsterTypeLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    @IBOutlet weak var cardsInfoTableView: UITableView!
    
    var card: Card? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        transformInDynamic(label: regionText)
        transformInDynamic(label: monsterTypeLabel)
    }
    
    func setupTableView() {
        cardsInfoTableView.delegate = self
        cardsInfoTableView.dataSource = self
    }
    
    func transformInDynamic(label: UILabel) {
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
    }

}

extension CardDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cardsInfoEffects") as? CardDetailTableViewCell
        
        if let cell = cell {
            cell.habilityImage.image = UIImage(named: "bla")
            cell.habilityText.text = "blabla"
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
