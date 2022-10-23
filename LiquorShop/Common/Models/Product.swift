//
//  Product.swift
//  LiquorShop
//
//  Created by RD on 23/10/22.
//

import Foundation

struct Product: Codable, Equatable {
    let id: String
    let imageURL: String
    let title: String
    let ratingCount: Decimal
    let price: [PriceDetail]
    
    init(id: String,
         imageURL: String,
         title: String,
         ratingCount: Decimal,
         price: [PriceDetail]) {
        self.id = id
        self.imageURL = imageURL
        self.title = title
        self.ratingCount = ratingCount
        self.price = price
    }
    
    func priceValue() -> PriceValue {
        if let validPrice = price.first {
            return PriceValue(decimalValue: validPrice.value)
        }
        
        return PriceValue(decimalValue: nil)
    }
}
