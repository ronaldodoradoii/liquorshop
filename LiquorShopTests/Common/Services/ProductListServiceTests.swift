//
//  ProductListServiceTests.swift
//  LiquorShopTests
//
//  Created by RD on 23/10/22.
//

import XCTest
import Nimble
@testable import LiquorShop


final class ProductListServiceTest: XCTestCase {
    
    var productListService: ProductListService!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        productListService = ProductListService(urlSession: urlSession)
        
        let data = ApiResponse.productsJSON.data(using: .utf8)
        MockURLProtocol.requestHandler = MockRequestHandler.build(statusCode: 200, data: data)
    }
    
    func testShouldFetchProductListSuccessfully() async throws {
        let expectedProducts = [Product.build(id:"1"),
                                Product.build(id:"2"),
                                Product.build(id:"3")]
        let productsContainer = Products(products: expectedProducts)
        let expectedData = try JSONEncoder().encode(productsContainer)
        MockURLProtocol.requestHandler = MockRequestHandler.build(statusCode: 200, data: expectedData)

        let products = try? await productListService.fetchProductList()

        await expect(products).to(equal(expectedProducts), description: "Expected product list is fetched and decoded")
    }
    
    func testShouldThrowErrorWhenFetchProductListFails() async throws {
        MockURLProtocol.requestHandler = MockRequestHandler.build(statusCode: 200, data: nil)

        var didThrowError: Error?
        
        do {
            _ = try await productListService.fetchProductList()
        } catch (let error) {
            didThrowError = error
        }

        await expect(didThrowError).toNot(beNil(), description: "Expected to throw an error if response data is invalid")
    }
    // TODO: - Missing test should throw when error code is not equal to 200
}
