//
//  ProductsTests.swift
//  LiquorShopTests
//
//  Created by RD on 23/10/22.
//

import XCTest

@testable import LiquorShop

final class ProductsTests: XCTestCase {
    func testShouldDecodeValidProductsJsonString() throws {
        let data = ApiResponse.productsJSON.data(using: .utf8)
        do {
            let products = try JSONDecoder().decode(Products.self, from: data!)
            print("\(products.products)")
            print("\(products)")
        } catch (let error) {
            XCTFail("Error can't decode Products model: \(error)")
        }
    }
}
