//
//  MainView.swift
//  LiquorShop
//
//  Created by RD on 23/10/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            let productListViewModel = ProductListViewModel(favouritesStore: FavouritesStore.shared,
                                                            navigationTitle: "Product List",
                                                            favouritesFilterOn: false)
            ProductListView(viewModel: productListViewModel, favouritesStore: FavouritesStore.shared)
                .tabItem {
                    Label("List", systemImage: "list.dash")
                }
            Color.green
                .tabItem {
                    Label("Favourites", systemImage: "heart.circle")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
