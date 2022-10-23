//
//  ProductTests.swift
//  LiquorShopTests
//
//  Created by RD on 23/10/22.
//

import XCTest
@testable import LiquorShop

final class ProductTests: XCTestCase {
    func testShouldReturnCorrectPriceValue() {
        let actualPriceValue = Product(id: "",
                                       imageURL: "",
                                       title: "",
                                       ratingCount: 5.0,
                                       price: [PriceDetail(message: "", value: 123456, isOfferPrice: false)]).priceValue().withDollarSign()
        
        XCTAssertEqual(actualPriceValue, "$123,456.00", "Expected to get correctly formatted price")
    }
    
    func testShouldReturnNotAvailableWhenPriceDetailIsEmpty() {
        let actualPriceValue = Product(id: "",
                                       imageURL: "",
                                       title: "",
                                       ratingCount: 5.0,
                                       price: []).priceValue().withDollarSign()
        
        XCTAssertEqual(actualPriceValue, "Not available", "Expected to get Not available text for empty Prioce Detail")
    }
}
