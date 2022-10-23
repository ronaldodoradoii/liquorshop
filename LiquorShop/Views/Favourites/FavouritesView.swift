//
//  FavouritesView.swift
//  LiquorShop
//
//  Created by RD on 23/10/22.
//

import SwiftUI

struct FavouritesView: View {
    @StateObject private var viewModel: FavouritesViewModel
    
    init(viewModel: FavouritesViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView(viewModel: FavouritesViewModel())
    }
}
