//
//  CurrencyModel.swift
//  CurrencyConversion
//
//  Created by 신정원 on 2023/10/13.
//

import Foundation

struct CurrencyModel: Codable {
    
    let result: String?
    let provider: String?
    let baseCode: String?
    let rates: [String : Double]?
    
    enum CodingKeys: String, CodingKey {
        case result
        case provider
        case baseCode = "base_code"
        case rates
    }
}
