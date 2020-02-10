//
//  SaveDeckViewController.swift
//  LOfRuneterraBuilds
//
//  Created by Júlio John Tavares Ramos on 10/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class SaveDeckViewController: UIViewController {

    @IBOutlet weak var titleView: TitleCellUIView!
    @IBOutlet weak var deckStyleTextField: UITextField!
    @IBOutlet weak var deckNameTextField: UITextField!
    
    var deckStylePickerView: UIPickerView = UIPickerView()
    var pickerData: [String] = ["Control", "Agro", "Combo", "Midrange", "None"]
    
    @IBOutlet weak var createDeckButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPickerView()
        
        createDeckButton.layer.cornerRadius = 6.0
        
        titleView.titleLabel.text = "Almost There!"
    }
    
    @IBAction func deckNameEndEditing(_ sender: UITextField) {
        self.view.endEditing(true)
    }
    
    @objc func donePicker() {
        deckStyleTextField.resignFirstResponder()
    }
    
    @objc func cancelPicker() {
        deckStyleTextField.text = ""
        deckStyleTextField.resignFirstResponder()
    }
    
    @IBAction func createDeckButtonPressed(_ sender: Any) {
        if let style = deckStyleTextField.text, let name =  deckNameTextField.text {
            if !style.isEmpty, !name.isEmpty {
                //TODO: Make the deck save!
                print("Deck salvo com sucesso!")
            } else {
                print("Dados estão vazios")
            }
        }
    }
}

extension SaveDeckViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let text = NSAttributedString(string: pickerData[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return text
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let row = pickerView.selectedRow(inComponent: 0)
        pickerView.selectRow(row, inComponent: 0, animated: false)
        self.deckStyleTextField.text = self.pickerData[row]
    }
    
    func createPickerView() -> UIPickerView {
        let picker: UIPickerView
        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 180))
        picker.backgroundColor = .clear
        picker.delegate = self
        picker.dataSource = self
        return picker
    }
    
    func setupPickerView() {
        let picker = createPickerView()
        self.deckStylePickerView = picker
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.black
        toolBar.barTintColor = .clear
        toolBar.tintColor = .white
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        deckStylePickerView.backgroundColor = .clear
        deckStyleTextField.inputView = deckStylePickerView
        deckStyleTextField.inputAccessoryView = toolBar
    }
    
}
