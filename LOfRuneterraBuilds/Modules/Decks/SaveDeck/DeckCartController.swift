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
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ragisterTableViewCell()
    }
    
    func ragisterTableViewCell(){
        let textFieldCell = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.cardsTableView.register(textFieldCell, forCellReuseIdentifier: "CustomTableViewCell")
    }
    
}

extension DeckCartController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomCardTableViewCell  else { return UITableViewCell() }
        
//        cell.card =
        
//        cell.configure(for: indexPath.row)
        return cell
        
    }
}
