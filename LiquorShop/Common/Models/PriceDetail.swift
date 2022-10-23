//
//  PriceDetail.swift
//  LiquorShop
//
//  Created by RD on 23/10/22.
//

import Foundation

struct PriceDetail: Codable, Equatable {
    let message: String
    let value: Decimal
    let isOfferPrice: Bool
}
