//
//  ProductListRow.swift
//  LiquorShop
//
//  Created by RD on 23/10/22.
//

import SwiftUI


struct ProductListRow: View {
    let title: String
    let price: String
    let imageURL: URL?
    let favouriteImageName: String
    let onTapFavourite: () -> Void
    
    init(title: String,
         price: String,
         imageURL: URL?,
         favouriteImageName: String,
         onTapFavourite: @escaping () -> Void) {
        self.title = title
        self.price = price
        self.imageURL = imageURL
        self.favouriteImageName = favouriteImageName
        self.onTapFavourite = onTapFavourite
    }
    
    var body: some View {
        HStack(spacing: 0) {
            if let imageURL = imageURL {
                // Async image download in here
            } else {
                Color.gray
                    .frame(width: CustomSize.productIconImage, height: CustomSize.productIconImage)
            }
            
            VStack(alignment: .leading) {
                Text("name: \(title)")
                Text("price: \(price)")
            }
            Spacer()

            
            Image(systemName: favouriteImageName)
                .frame(width: CustomSize.iconTappableArea, height: CustomSize.iconTappableArea)
                .contentShape(Rectangle())
                .onTapGesture {
                    onTapFavourite()
                }
        }
        .padding(.horizontal, CustomSize.small)
    }
}

#if DEBUG
struct ProductListRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductListRow(title: "Some product name", price: "$1,000.00", imageURL: URL(string: "https://media.danmurphys.com.au/dmo/product/904960-1.png?impolicy=PROD_SM"), favouriteImageName: "heart", onTapFavourite: { })
    }
}
#endif

