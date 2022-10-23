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
            Color.blue
                .tabItem {
                    Label("Products", systemImage: "list.dash")
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
