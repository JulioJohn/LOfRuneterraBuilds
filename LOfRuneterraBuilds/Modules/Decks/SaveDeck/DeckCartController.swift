//
//  DeckCart.swift
//  LOfRuneterraBuilds
//
//  Created by Patricia Amado Ferreira de Mello on 10/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation
import UIKit

class DeckCartController: UIViewController {
    
    @IBOutlet weak var customTopBar: TopBarUIView!
    
    @IBOutlet weak var cardsTableView: UITableView!
    
    var card: Card? = nil
    
    var cards: [Card?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setTopBar()
        
//        self.customTopBar.rightButton.add
    }
    
    
    func setupTableView() {
        self.cardsTableView.delegate = self
        self.cardsTableView.dataSource = self
        
        self.cardsTableView.separatorStyle = .none
    }
    
    @objc func send(){
    
            
        let vc = UIStoryboard(name: "SaveDeck", bundle: .none).instantiateInitialViewController() as! SaveDeckViewController
        
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func setTopBar(){
        self.customTopBar.leftButton.setTitle("Edit", for: .normal)
        self.customTopBar.leftButton.titleLabel?.font = UIFont.scaledFont(for: "OpenSans-Regular", size: 17)
        
        self.customTopBar.rightButton.setTitle("Save Deck", for: .normal)
        self.customTopBar.rightButton.titleLabel?.font = UIFont.scaledFont(for: "OpenSans-Regular", size: 17)
        
        self.customTopBar.title.text = "My Deck"
        self.customTopBar.title.font = UIFont.scaledFont(for: "OpenSans-SemiBold", size: 17)
    }
    
    
    
}


extension DeckCartController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomCardTableViewCell  else { return UITableViewCell() }

        cell.cardName.text = cards[indexPath.row]?.name
        cell.cardName.font = UIFont.scaledFont(for: "OpenSans-Bold", size: 17)
        
        cell.cardMana.text = "\(cards[indexPath.row]?.cost)"
        cell.cardMana.font = UIFont.scaledFont(for: "OpenSans-Regular", size: 17)
        
        cell.cardsAmount.text = "2/3"
        cell.cardsAmount.font = UIFont.scaledFont(for: "OpenSans-Regular", size: 17)
        
        return cell
    }
    
}

//extension DeckBuilderController: TopBarDelegate {
//    func goToCardSave() {
//        performSegue(withIdentifier: "goToCardDetails", sender: self.custom)
//
//    }
//    
//}
