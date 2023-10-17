//
//  ViewController.swift
//  CurrencyConversion
//
//  Created by 신정원 on 2023/10/13.
//

import UIKit

class PickerViewController: UIViewController {
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var usbTextField: UITextField!
    @IBOutlet weak var selectedTextField: UITextField!
    @IBOutlet weak var selectedCurrencyName: UILabel!
    
    
    var rates: [(String, Double)]? = nil
    
    var selectedRow = 0 {
        didSet {
            self.selectedCurrencyName.text = rates?[selectedRow].0
            
            self.selectedTextField.text = calculateCurrency()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "환율 계산기 Picker"
        
        self.currencyPicker.delegate = self
        self.currencyPicker.dataSource = self
        
        self.usbTextField.delegate = self
        
        fetchJson()
        
    }
    
    func calculateCurrency() -> String {
        let selectedValue = rates?[selectedRow].1 ?? 0
        let usdValue = Double(usbTextField.text ?? "") ?? 0
        
        let resultValue = String(format: "%.2f", selectedValue * usdValue)
        return resultValue
        
    }
    
    func fetchJson() {
        NetworkLayer.fetchJson { model in
            self.rates = model.rates?.sorted{ $0.key < $1.key }
            
            DispatchQueue.main.async {
                self.currencyPicker.reloadAllComponents()
            }
        }
    }

}

extension PickerViewController : UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        selectedTextField.text = calculateCurrency()
    }
}

extension PickerViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    //컴포넌트 갯수 리턴
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //보여주는 데이터 갯수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rates?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let key = rates?[row].0 ?? ""
        let value = rates?[row].1.description ?? ""
        return key + " " + value
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedRow = row
    }
}

