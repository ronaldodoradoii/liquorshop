//
//  MainView.swift
//  LiquorShop
//
//  Created by RD on 23/10/22.
//

import SwiftUI
import URLImage
import URLImageStore

struct MainView: View {
    var body: some View {
        let urlImageService = URLImageService(fileStore: URLImageFileStore(),
                                          inMemoryStore: URLImageInMemoryStore())
        
        TabView {
            ProductListView(viewModel: ProductListViewModel(favouritesStore: FavouritesStore.shared,
                                                            navigationTitle: "Product List",
                                                            favouritesFilterOn: false),
                             favouritesStore: FavouritesStore.shared)
            .environment(\.urlImageService, urlImageService)
                .tabItem {
                    Label("List", systemImage: "list.dash")
                }
            FavouritesView(viewModel: ProductListViewModel(favouritesStore: FavouritesStore.shared,
                                                           navigationTitle: "Favourites",
                                                           favouritesFilterOn: true),
                           favouritesStore: FavouritesStore.shared)
            .environment(\.urlImageService, urlImageService)
                .tabItem() {
                    Label("Favourites", systemImage: "heart.circle")
                }
        }
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
