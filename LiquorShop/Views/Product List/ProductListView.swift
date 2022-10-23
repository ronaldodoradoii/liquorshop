//
//  ProductListView.swift
//  LiquorShop
//
//  Created by RD on 23/10/22.
//

import SwiftUI

struct ProductListView: View {
    @StateObject private var viewModel: ProductListViewModel
    let favouritesStore: FavouritesStoreProtocol
    
    init(viewModel: ProductListViewModel, favouritesStore: FavouritesStoreProtocol) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.favouritesStore = favouritesStore
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBlue, .font: UIFont(name: "Arial Rounded MT Bold", size: CustomSize.navigationTitleLargeFont)!]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemBlue, .font: UIFont(name: "Arial Rounded MT Bold", size: CustomSize.navigationTileFont)!]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if let _ = viewModel.errorOccured {
                    Text("Error loading the page")
                } else if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(1.5, anchor: .center)
                } else if viewModel.isListEmpty {
                    Text("No products found")
                } else {
                    List {
                        ForEach(viewModel.products, id: \.id) { product in
                            ZStack(alignment: .leading) {
                                ProductListRow(title: product.title,
                                               price: product.priceValue().withDollarSign(),
                                               imageURL: URL(string: product.imageURL),
                                               favouriteImageName: viewModel.systemImageName(for: product)) {
                                    viewModel.toggleFavourite(for: product)
                                }
                                let productDetailViewModel = ProductDetailViewModel(favouritesStore: favouritesStore,
                                                                                    id: product.id,
                                                                                    productTitle: product.title,
                                                                                    price: product.priceValue().withDollarSign(),
                                                                                    ratingCount: product.ratingCount,
                                                                                    imageURL: URL(string: product.imageURL),
                                                                                    delegate: viewModel)
                                let destination = ProductDetailView(viewModel: productDetailViewModel)
                                NavigationLink(destination: destination) {
                                    EmptyView()
                                }
                                .opacity(0.0)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(viewModel.navigationTitle)
        }
        .onAppear() {
            viewModel.fetchProductList()
        }
    }
}

#if DEBUG
struct ProductsListView_Previews: PreviewProvider {
    
    static var previews: some View {
        let vm = ProductListViewModelStub(products: createProducts(), favourites: ["2", "3", "7"], favouritesFilterOn: false)
        ProductListView(viewModel: vm, favouritesStore: FavouritesStoreStub())
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

class ProductListViewModelStub: ProductListViewModel {
    var favourites = [String]()
    
    convenience init(products: [Product], favourites: [String] = [], favouritesFilterOn: Bool) {
        self.init(favouritesStore: FavouritesStoreStub(),
                  navigationTitle: "Product List",
                  favouritesFilterOn: favouritesFilterOn)
        self.products = products
        self.favourites = favourites
        if favouritesFilterOn {
            self.products = products.filter { favourites.contains($0.id) }
        }
    }
    
    override func fetchProductList() { }
    
    override func systemImageName(for product: Product) -> String {
        return favourites.contains(product.id) ? "heart.fill" : "heart"
    }
}
#endif
