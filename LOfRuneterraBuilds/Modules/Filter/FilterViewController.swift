//
//  FilterViewController.swift
//  LOfRuneterraBuilds
//
//  Created by Júlio John Tavares Ramos on 09/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var manaView: TitleCellUIView!
    @IBOutlet weak var regionView: TitleCellUIView!
    @IBOutlet weak var typeView: TitleCellUIView!
    @IBOutlet weak var rarityView: TitleCellUIView!
    
    
    @IBOutlet weak var mana1: UIButton!
    @IBOutlet weak var mana2: UIButton!
    @IBOutlet weak var mana3: UIButton!
    @IBOutlet weak var mana4: UIButton!
    @IBOutlet weak var mana5: UIButton!
    @IBOutlet weak var mana6: UIButton!
    
    @IBOutlet weak var demaciaButton: UIButton!
    @IBOutlet weak var freljordbutton: UIButton!
    @IBOutlet weak var ioniaButton: UIButton!
    @IBOutlet weak var piltoverButton: UIButton!
    @IBOutlet weak var noxusButton: UIButton!
    @IBOutlet weak var shadowButton: UIButton!
    
    
    var mana: Int? = nil
    var region: String? = nil
    var type: String? = nil
    
    var filterCards: Filter = Filter(name: nil, regions: nil, cost: nil)
    
    
    //TODO: Filter for Rarity and Type
    //TODO: Mana can be filtred more than one for time
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeFont(view: manaView, fontSize: 17.0)
        changeFont(view: regionView, fontSize: 17.0)
        changeFont(view: typeView, fontSize: 17.0)
        changeFont(view: rarityView, fontSize: 17.0)
        
        manaView.titleLabel.text = "Mana"
        regionView.titleLabel.text = "Region"
        typeView.titleLabel.text = "Type"
        rarityView.titleLabel.text = "Rarity"
    }
    
    func changeFont(view: TitleCellUIView, fontSize: CGFloat) {
        view.titleLabel.font = view.titleLabel.font.withSize(fontSize)
    }
    
    func manaButtonSelected(button: UIButton, mana: Int) {
        //change button
        buttonTapped(button: button)
        
        //update filter
        self.mana = mana
        
        updateFilter()
    }
    
    func regionButtonSelected(button: UIButton, region: Faction) {
        
        //mark as selected
        buttonTapped(button: button)
        
        print(button.isSelected)
        if button.isSelected {
            //unselect all regions
            unselectAllRegionButtons()
            
            //except themselve
            button.isSelected = true
            button.alpha = 1.0
            
            //update filter
            self.region = region.rawValue
        } else {
            //unselect all regions
            unselectAllRegionButtons()
            self.region = nil
        }
        
        updateFilter()
    }
    
    func buttonTapped(button: UIButton) {
        button.isSelected = !button.isSelected
    }
    
    func unselectAllRegionButtons() {
        let unselectedAlpha: CGFloat = 0.2
        self.demaciaButton.alpha = unselectedAlpha
        self.freljordbutton.alpha = unselectedAlpha
        self.ioniaButton.alpha = unselectedAlpha
        self.piltoverButton.alpha = unselectedAlpha
        self.noxusButton.alpha = unselectedAlpha
        self.shadowButton.alpha = unselectedAlpha
        
        self.demaciaButton.isSelected = false
        self.freljordbutton.isSelected = false
        self.ioniaButton.isSelected = false
        self.piltoverButton.isSelected = false
        self.noxusButton.isSelected = false
        self.shadowButton.isSelected = false
    }
    
    func updateFilter() {
        self.filterCards = Filter.init(name: nil, regions: region, cost: mana)
        print(filterCards.cost)
        print(filterCards.region)
    }
    
    //Mana buttons
    @IBAction func mana1(_ sender: Any) {
        manaButtonSelected(button: self.mana1, mana: 1)
    }
    @IBAction func mana2(_ sender: Any) {
        manaButtonSelected(button: self.mana2, mana: 2)
    }
    @IBAction func mana3(_ sender: Any) {
        manaButtonSelected(button: self.mana3, mana: 3)
    }
    @IBAction func mana4(_ sender: Any) {
        manaButtonSelected(button: self.mana4, mana: 4)
    }
    @IBAction func mana5(_ sender: Any) {
        manaButtonSelected(button: self.mana5, mana: 5)
    }
    @IBAction func mana6(_ sender: Any) {
        manaButtonSelected(button: self.mana6, mana: 6)
    }
    
    @IBAction func regionDemacia(_ sender: Any) {
        regionButtonSelected(button: demaciaButton, region: .demacia)
    }
    @IBAction func regionFreljord(_ sender: Any) {
        regionButtonSelected(button: freljordbutton, region: .freljord)
    }
    @IBAction func regionIonia(_ sender: Any) {
        regionButtonSelected(button: ioniaButton, region: .ionia)
    }
    @IBAction func regionPiltover(_ sender: Any) {
        regionButtonSelected(button: piltoverButton, region: .piltoverAndZaun)
    }
    @IBAction func regionNoxus(_ sender: Any) {
        regionButtonSelected(button: noxusButton, region: .noxus)
    }
    @IBAction func regionShadow(_ sender: Any) {
        regionButtonSelected(button: shadowButton, region: .shadowIsles)
    }
    
    
    
    
    
}

extension FilterViewController {
    
    
    
}
