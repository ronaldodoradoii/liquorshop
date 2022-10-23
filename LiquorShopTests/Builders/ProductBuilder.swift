//
//  ProductBuilder.swift
//  LiquorShopTests
//
//  Created by RD on 23/10/22.
//

import Foundation
@testable import LiquorShop

extension Product {
    static func build(id: String = "some id",
                      imageURL: String = "some url",
                      title: String = "a product title",
                      ratingCount: Decimal = 5.0,
                      price: [PriceDetail] = [PriceDetail(message: "This is on sale", value: 25.50, isOfferPrice: false)]) -> Product {
        Product(id: id, imageURL: imageURL, title: title, ratingCount: ratingCount, price: price)
    }
}
