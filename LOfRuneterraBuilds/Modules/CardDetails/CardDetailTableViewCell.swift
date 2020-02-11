//
//  CardDetailTableViewCell.swift
//  LOfRuneterraBuilds
//
//  Created by Júlio John Tavares Ramos on 05/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class CardDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var habilityImage: UIImageView!
    @IBOutlet weak var habilityText: UILabel! {
        didSet {
            habilityText.font = UIFont.scaledFont(for: "OpenSans-Regular", size: 15)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
