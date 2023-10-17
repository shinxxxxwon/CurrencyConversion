//
//  ListViewController.swift
//  CurrencyConversion
//
//  Created by 신정원 on 2023/10/13.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var inputUsbValue: UITextField!
    
    @IBOutlet weak var currencyTableView: UITableView!
    
    var rates: [(String, Double)]? = nil
    var usdValue: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "환율 계산기"
        
        inputUsbValue.delegate = self
        
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
        
        let currencyCellNib = UINib(nibName: "CurrencyCell", bundle: nil)
        
        currencyTableView.register(currencyCellNib, forCellReuseIdentifier: "CurrencyCell")
        
        fetchJson()
    }
    
    func fetchJson() {
        NetworkLayer.fetchJson { model in
            self.rates = model.rates?.sorted{ $0.key < $1.key }
            
            DispatchQueue.main.async {
                self.currencyTableView.reloadData()
            }
        }
    }
}

extension ListViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        usdValue = Double(textField.text ?? "")
        currencyTableView.reloadData()
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
        
        if let rate = rates?[indexPath.row] {
            cell.presentCurrency(rate: rate, usdValue: usdValue)
        }
        
        return cell
    }
    
    
}
