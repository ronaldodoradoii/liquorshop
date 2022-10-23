//
//  PriceValue.swift
//  LiquorShop
//
//  Created by RD on 23/10/22.
//

import Foundation

struct PriceValue {
    let value: Decimal?
    
    init(decimalValue: Decimal?) {
        self.value = decimalValue
    }
    
    func withDollarSign() -> String {
        guard let value = value else {
            return "Not available"
        }
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.currencyCode = "AUD"
        formatter.locale = Locale(identifier: "en_au")
        formatter.numberStyle = .currency
        
        return formatter.string(from: NSDecimalNumber(decimal: value)) ?? "$\(NSDecimalNumber(decimal: value))"
    }
}
