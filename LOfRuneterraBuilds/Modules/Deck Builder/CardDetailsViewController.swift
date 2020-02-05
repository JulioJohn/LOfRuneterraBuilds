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
        
        cardsInfoTableView.separatorStyle = .none
    }
    
    func transformInDynamic(label: UILabel) {
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
    }

}

extension CardDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let card = card {
            if card.keywords.count > 0 {
                return card.keywords.count
            }
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cardsInfoTableView.dequeueReusableCell(withIdentifier: "cardsInfoEffects", for: indexPath) as? CardDetailTableViewCell
        
        if let cell = cell {
            cell.habilityImage.image = UIImage(named: "\(card?.keywordRefs[indexPath.row])")
            cell.habilityText.text = card?.keywordRefs[indexPath.row] //aqui na verdade é o efeito da carta!
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
