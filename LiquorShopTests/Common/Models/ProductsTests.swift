//
//  ProductsTests.swift
//  LiquorShopTests
//
//  Created by RD on 23/10/22.
//

import XCTest
import Nimble
@testable import LiquorShop

final class ProductsTests: XCTestCase {
    func testShouldDecodeValidProductsJsonString() throws {
        var products: Products?
        
        let data = ApiResponse.productsJSON.data(using: .utf8)
        do {
            products = try JSONDecoder().decode(Products.self, from: data!)
        } catch (let error) {
            XCTFail("Error can't decode Products model: \(error)")
        }
        
        expect(products).toNot(beNil(), description: "Error can't decode Products model")
    }
}
