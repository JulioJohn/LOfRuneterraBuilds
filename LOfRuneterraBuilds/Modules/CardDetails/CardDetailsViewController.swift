//
//  CardDetailsViewController.swift
//  LOfRuneterraBuilds
//
//  Created by Júlio John Tavares Ramos on 05/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class CardDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var navegationTitle: UINavigationItem!
    @IBOutlet weak var titleCell: TitleCellUIView!
    @IBOutlet weak var cardSelectImage: CardSelectController!
    
    @IBOutlet weak var regionLabel: UILabel! {
        didSet {
            regionLabel.font = UIFont.scaledFont(for: "OpenSans-Regular", size: 11)
        }
    }
    @IBOutlet weak var regionImage: UIImageView!
    
    @IBOutlet weak var monsterTypeLabel: UILabel! {
        didSet {
            monsterTypeLabel.font = UIFont.scaledFont(for: "OpenSans-Regular", size: 11)
        }
    }
    @IBOutlet weak var monsterImage: UIImageView!
    
    @IBOutlet weak var rarityLabel: UILabel! {
        didSet {
            rarityLabel.font = UIFont.scaledFont(for: "OpenSans-Regular", size: 11)
        }
    }
    @IBOutlet weak var rarityImage: UIImageView!
    
    @IBOutlet weak var cardsInfoTableView: UITableView!
    
    @IBOutlet weak var cardEffectLabel: UILabel! {
        didSet {
            attackLabel.font = UIFont.scaledFont(for: "OpenSans-Bold", size: 15)
        }
    }
    
    @IBOutlet weak var cardSpeakLabel: UILabel! {
        didSet {
            cardSpeakLabel.font = UIFont.scaledFont(for: "OpenSans-Regular", size: 15)
        }
    }
    
    @IBOutlet weak var tableHeigthConstrain: NSLayoutConstraint!
    
    @IBOutlet weak var attackLabel: UILabel! {
        didSet {
            attackLabel.font = UIFont.scaledFont(for: "OpenSans-SemiBold", size: 17)
        }
    }
    @IBOutlet weak var defenseLabel: UILabel! {
        didSet {
            defenseLabel.font = UIFont.scaledFont(for: "OpenSans-SemiBold", size: 17)
        }
    }
    
    var card: Card? = nil
    var cardInfos: CardInfo? = nil
    
    var lorService: LORService = LORService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        setupTableViewData()
        
        consumeJsonCardInfos()
        
        transformInDynamic(label: regionLabel)
        transformInDynamic(label: monsterTypeLabel)
        transformInDynamic(label: rarityLabel)
    }
    
    func consumeJsonCardInfos() {
        self.lorService.infosLoadJson(filename: DataUtils.globals.getFileName()) { (cardInfos, error) in
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
    
    func setupNavBar() {
        if let card = card {
            self.navegationTitle.title = card.name
        }
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    func setupTableView() {
        cardsInfoTableView.delegate = self
        cardsInfoTableView.dataSource = self
        
        cardsInfoTableView.separatorStyle = .none
    }
    
    func setupTableViewData() {
        if let card = card, let faction = Faction(rawValue: card.regionRef) {
            let nameText = card.name
            let regionText = card.region
            let monsterTypeText = card.type
            let rarityText = card.rarity
            let effectText = card.descriptionWithoutXML()
            let flavorText = card.flavorText
            let attackText = Int(card.attack)
            let defenseText = Int(card.health)
            
            self.titleCell.titleLabel.text = nameText
            self.regionLabel.text = regionText
            self.monsterTypeLabel.text = monsterTypeText
            self.rarityLabel.text = rarityText
            self.cardEffectLabel.text = effectText
            self.cardSpeakLabel.text = flavorText
            self.attackLabel.text = "\(attackText)"
            self.defenseLabel.text = "\(defenseText)"
            
            self.regionImage.image = faction.getImage()
            cardSelectImage.changeCard(card: card)
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
            self.tableHeigthConstrain.constant = 44 * CGFloat(card.keywords.count)
            if card.keywords.count > 0 {
                return card.keywords.count
            }
        }
        self.tableHeigthConstrain.constant = 0
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let cardInfos = cardInfos {
            if cardInfos.keywords.count > 0 {
                return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cardsInfoTableView.dequeueReusableCell(withIdentifier: "cardsInfoEffects", for: indexPath) as? CardDetailTableViewCell
        
        //Se tiver as informacoes das cartas carregadas
        if let cell = cell, let card = card, let cardInfos = cardInfos {
            let habilityText = card.keywordRefs[indexPath.row]
            //Se tiver descricao carregada
            let effectDescription = cardInfos.searchForHabilityDescription(hability: habilityText)
            
            cell.habilityText.text = habilityText + " - " + effectDescription
            
            return cell
        }
        
        return UITableViewCell()
    }
}
