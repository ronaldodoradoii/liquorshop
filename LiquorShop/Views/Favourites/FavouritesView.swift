//
//  FavouritesView.swift
//  LiquorShop
//
//  Created by RD on 23/10/22.
//

import SwiftUI

struct FavouritesView: View {
    @StateObject private var viewModel: ProductListViewModel
    let favouritesStore: FavouritesStoreProtocol
    
    init(viewModel: ProductListViewModel, favouritesStore: FavouritesStoreProtocol) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.favouritesStore = favouritesStore
    }
    
    var body: some View {
        ProductListView(viewModel: viewModel,
                         favouritesStore: favouritesStore)
    }
}

#if DEBUG
struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ProductListViewModelStub(products: createProducts(), favourites: ["7", "8", "9"], favouritesFilterOn: true)
        FavouritesView(viewModel: vm, favouritesStore: FavouritesStoreStub())
    }
    
    static func createProducts() -> [Product] {
        var products = [Product]()
        for i in 1...500 {
            products.append(Product(id: "\(i)",
                                    imageURL: "",
                                    title: "Product \(i)",
                                    ratingCount: 5.0,
                                    price: [PriceDetail(message: "On sale", value: Decimal(10 + i), isOfferPrice: true)]))
        }
        return products
    }
}
#endif


