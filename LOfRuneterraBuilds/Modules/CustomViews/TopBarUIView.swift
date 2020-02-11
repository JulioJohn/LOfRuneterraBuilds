//
//  TopBarUIView.swift
//  LOfRuneterraBuilds
//
//  Created by Patricia Amado Ferreira de Mello on 11/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

protocol TopBarDelegate: class {
    func goToCardSave()
}

class TopBarUIView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var title: UILabel!
    
    weak var delegate: TopBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("TopBarUIView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    @IBAction func goToCardSave(_ sender: Any) {
        delegate?.goToCardSave()
    }
}
