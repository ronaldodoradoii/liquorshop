//
//  ProductTests.swift
//  LiquorShopTests
//
//  Created by RD on 23/10/22.
//

import XCTest
import Nimble
@testable import LiquorShop

final class ProductTests: XCTestCase {
    func testShouldReturnCorrectPriceValue() {
        let actualPriceValue = Product(id: "",
                                       imageURL: "",
                                       title: "",
                                       ratingCount: 5.0,
                                       price: [PriceDetail(message: "", value: 123456, isOfferPrice: false)]).priceValue().withDollarSign()
        
        expect(actualPriceValue).to(equal("$123,456.00"), description: "Expected to get correctly formatted price")
    }
    
    func testShouldReturnNotAvailableWhenPriceDetailIsEmpty() {
        let actualPriceValue = Product(id: "",
                                       imageURL: "",
                                       title: "",
                                       ratingCount: 5.0,
                                       price: []).priceValue().withDollarSign()
        
        expect(actualPriceValue).to(equal("Not available"), description: "Expected to get Not available text for empty Prioce Detail")
    }
}
