//
//  ProductListViewModel.swift
//  LiquorShop
//
//  Created by RD on 23/10/22.
//

import Foundation

@MainActor
class ProductListViewModel: ObservableObject {
    @Published var products = [Product]()
    @Published var isLoading = false
    @Published var errorOccured: CustomError?
    @Published var isListEmpty = false
    
    private let favouriteImageName = "heart.fill"
    private let notFavouriteImageName = "heart"
    let navigationTitle: String
    let productListService: ProductListServiceProtocol
    let favouritesStore: FavouritesStoreProtocol
    let favouritesFilterOn: Bool
    
    init(productListService: ProductListServiceProtocol = ProductListService(),
         favouritesStore: FavouritesStoreProtocol,
         navigationTitle: String,
         favouritesFilterOn: Bool) {
        self.productListService = productListService
        self.navigationTitle = navigationTitle
        self.favouritesStore = favouritesStore
        self.favouritesFilterOn = favouritesFilterOn
    }
    
    func fetchProductList() {
        isLoading = true
        isListEmpty = false
        Task {
            do {
                products = try await productListService.fetchProductList()
                refreshProducts()
                isLoading = false
                errorOccured = nil
            } catch {
                errorOccured = CustomError.networkError
            }
        }
    }
    
    func systemImageName(for product: Product) -> String {
        return favouritesStore.checkIfFavourite(id: product.id) ? favouriteImageName : notFavouriteImageName
    }
    
    func toggleFavourite(for product: Product) {
        favouritesStore.toggleFavourite(id: product.id)
        refreshProducts()
    }
    
    private func refreshProducts() {
        if favouritesFilterOn {
            products = products.filter { favouritesStore.checkIfFavourite(id: $0.id) }
        } else {
            products = products
        }
        isListEmpty = products.isEmpty
    }
}

// MARK: - ProductDetailViewModelDelegate
extension ProductListViewModel: ProductDetailViewModelDelegate {
    func didUpdateProduct(id: String) {
        refreshProducts()
    }
}
