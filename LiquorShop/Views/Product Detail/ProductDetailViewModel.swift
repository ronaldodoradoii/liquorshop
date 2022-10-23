//
//  ProductDetailViewModel.swift
//  LiquorShop
//
//  Created by RD on 23/10/22.
//

import Foundation

@MainActor
protocol ProductDetailViewModelDelegate: AnyObject {
    func didUpdateProduct(id: String)
}

@MainActor
class ProductDetailViewModel: ObservableObject {
    @Published var favouriteImage: String
    weak var delegate: ProductDetailViewModelDelegate?
    let favouritesStore: FavouritesStoreProtocol
    let id: String
    let productTitle: String
    let price: String
    let ratingCount: Decimal
    let imageURL: URL?
    private let favouriteImageName = "heart.fill"
    private let notFavouriteImageName = "heart"
    
    init(favouritesStore: FavouritesStoreProtocol,
         id: String,
         productTitle: String,
         price: String,
         ratingCount: Decimal,
         imageURL: URL?,
         delegate: ProductDetailViewModelDelegate? = nil) {
        self.favouritesStore = favouritesStore
        self.id = id
        self.productTitle = productTitle
        self.price = price
        self.ratingCount = ratingCount
        self.imageURL = imageURL
        self.favouriteImage = favouritesStore.checkIfFavourite(id: id) ? favouriteImageName : notFavouriteImageName
        self.delegate = delegate
    }
    
    func toggleFavourites() {
        favouritesStore.toggleFavourite(id: id)
        refresh()
        delegate?.didUpdateProduct(id: id)
    }
    
    func refresh() {
        favouriteImage = favouritesStore.checkIfFavourite(id: id) ? favouriteImageName : notFavouriteImageName
    }
}

