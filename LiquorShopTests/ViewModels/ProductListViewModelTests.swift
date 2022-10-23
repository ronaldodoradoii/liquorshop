//
//  ProductListViewModelTests.swift
//  LiquorShopTests
//
//  Created by RD on 23/10/22.
//

import XCTest
import Nimble
@testable import LiquorShop

class FavouritesStorageSpy: FavouritesStoreProtocol {
    func addFavourite(id: String) {
    }
    
    func removeFavourite(id: String) {
    }
    
    func toggleFavourite(id: String) {
    }
    
    func checkIfFavourite(id: String) -> Bool {
        return true
    }
}

class ProductListServiceSpy: ProductListServiceProtocol {
    var products: [Product] = []
    var error: Error?
    
    func fetchProductList() async throws -> [LiquorShop.Product] {
        if let error = error {
            throw error
        }
        
        return products
    }
}

@MainActor
final class ProductListViewModelTests: XCTestCase {

    var viewModel: ProductListViewModel!
    var productListService: ProductListServiceSpy!
    var favouritesStorage: FavouritesStorageSpy!
    
    override func setUpWithError() throws {
        productListService = ProductListServiceSpy()
        favouritesStorage = FavouritesStorageSpy()
        
        viewModel = ProductListViewModel(productListService: productListService,
                                         favouritesStore: favouritesStorage,
                                         navigationTitle: "Some title",
                                         favouritesFilterOn: false)
    }

    func testShouldUpdateProductsWhenFetchProductsIsSuccessfully() throws {
        let expectedProducts = [Product.build(id: "1"), Product.build(id: "2"), Product.build(id: "3")]
        productListService.products = expectedProducts
        
        viewModel.fetchProductList()
        
        expect(self.viewModel.products).toEventually(equal(expectedProducts))
    }
    
    func testShouldThrowErrorAndShowErrorStateWhenFetchProductsFailed() throws {
        productListService.error = CustomError.networkError
        
        viewModel.fetchProductList()

        expect(self.viewModel.errorOccured).toEventuallyNot(beNil())
    }
    
    //TODO: - Missing tests in here for other ViewModel methods and states
}
