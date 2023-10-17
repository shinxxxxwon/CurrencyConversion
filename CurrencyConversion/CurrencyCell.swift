//
//  CurrencyCell.swift
//  CurrencyConversion
//
//  Created by 신정원 on 2023/10/17.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    @IBOutlet private weak var leftLabel: UILabel!
    @IBOutlet private weak var rightLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func presentCurrency(rate: (String, Double), usdValue: Double?) {
        
        let changedValue = rate.1 * (usdValue ?? 0)
        let resultValue = String(format: "%.2f", changedValue)
        
        self.leftLabel.text = rate.0
        self.rightLabel.text = resultValue.description
    }
    
}
