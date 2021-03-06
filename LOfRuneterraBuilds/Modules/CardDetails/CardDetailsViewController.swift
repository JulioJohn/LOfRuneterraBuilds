//
//  CardDetailsViewController.swift
//  LOfRuneterraBuilds
//
//  Created by Júlio John Tavares Ramos on 05/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class CardDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var regionImage: UIImageView!
    
    @IBOutlet weak var monsterTypeLabel: UILabel!
    @IBOutlet weak var monsterImage: UIImageView!
    
    @IBOutlet weak var rarityLabel: UILabel!
    @IBOutlet weak var rarityImage: UIImageView!
    
    @IBOutlet weak var cardsInfoTableView: UITableView!
    
    @IBOutlet weak var cardEffectLabel: UILabel!
    @IBOutlet weak var cardSpeakLabel: UILabel!
    
    
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    
    var card: Card? = nil
    var cardInfos: CardInfo? = nil
    
    var lorService: LORService = LORService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupTableViewData()
        
        consumeJsonCardInfos()
        
        transformInDynamic(label: regionLabel)
        transformInDynamic(label: monsterTypeLabel)
        transformInDynamic(label: rarityLabel)
    }
    
    func consumeJsonCardInfos() {
        self.lorService.infosLoadJson(filename: "globals-en_us") { (cardInfos, error) in
            if error != nil {
                print(error)
                return
            }
            
            self.cardInfos = cardInfos
            
            DispatchQueue.main.async {
                self.cardsInfoTableView.reloadData()
            }
        }
    }
    
    func setupTableView() {
        cardsInfoTableView.delegate = self
        cardsInfoTableView.dataSource = self
        
        cardsInfoTableView.separatorStyle = .none
    }
    
    func setupTableViewData() {
        if let card = card {
            let nameText = card.name
            let regionText = card.region
            let monsterTypeText = card.type
            let rarityText = card.rarity
            let effectText = card.description
            let flavorText = card.flavorText
            let attackText = Int(card.attack)
            let defenseText = Int(card.health)
            
            self.nameLabel.text = nameText
            self.regionLabel.text = regionText
            self.monsterTypeLabel.text = monsterTypeText
            self.rarityLabel.text = rarityText
            self.cardEffectLabel.text = effectText
            self.cardSpeakLabel.text = flavorText
            self.attackLabel.text = "\(attackText)"
            self.defenseLabel.text = "\(defenseText)"
            
            self.regionImage.image = UIImage(named: regionText)
            makeImageRound(image: self.regionImage)
            self.monsterImage.image = UIImage(named: monsterTypeText)
            makeImageRound(image: self.monsterImage)
            self.rarityImage.image = UIImage(named: rarityText)
            makeImageRound(image: self.rarityImage)
        }
    }
    
    func makeImageRound(image: UIImageView) {
        image.layer.cornerRadius = image.bounds.width/2
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
        
        //Se tiver as informacoes das cartas carregadas
        if let cell = cell, let card = card, let cardInfos = cardInfos {
            
            let habilityText = card.keywordRefs[indexPath.row]
            //Se tiver descricao carregada
            let effectDescription = cardInfos.searchForHabilityDescription(hability: habilityText)
        
            cell.habilityImage.image = UIImage(named: habilityText)
            makeImageRound(image: cell.habilityImage)
        
            cell.habilityText.text = habilityText + ": " + effectDescription
            
            return cell
        }

        
        return UITableViewCell()
    }
}
