//
//  ProductListRow.swift
//  LiquorShop
//
//  Created by RD on 23/10/22.
//

import SwiftUI
import URLImage

struct ProductListRow: View {
    @State private var showingAlert = false
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
                URLImage(imageURL,
                         content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: CustomSize.productIconImage, height: CustomSize.productIconImage)
                })
                .padding(CustomSize.small)
            } else {
                Color.gray
                    .frame(width: CustomSize.productIconImage, height: CustomSize.productIconImage)
                    .padding(CustomSize.small)
            }
            
            VStack(alignment: .leading) {
                Text("\(title)")
                    .font(Font.callout.weight(.semibold))
                    .padding(.bottom, CustomSize.smallest)
                Text("\(price)")
                    .font(Font.subheadline.weight(.regular))
                    .foregroundColor(.gray)
                HStack {
                    Text("Add to cart")
                        .font(Font.footnote.weight(.regular))
                        .foregroundColor(.blue)
                    Image(systemName: "cart.badge.plus")
                        .font(.system(size: CustomSize.iconAddToCart))
                }.onTapGesture {
                    showingAlert = true
                }
            }

            Spacer()
            Image(systemName: favouriteImageName)
                .font(.system(size: CustomSize.iconFavourite))
                .foregroundColor(.blue)
                .frame(width: CustomSize.iconTappableArea, height: CustomSize.iconTappableArea)
                .contentShape(Rectangle())
                .onTapGesture {
                    onTapFavourite()
                }
        }
        .padding(.horizontal, CustomSize.small)
        .padding(.vertical, CustomSize.zero)
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Added to cart"),
                message: Text("Message")
            )
        }
    }
}

#if DEBUG
struct ProductListRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductListRow(title: "Some product name", price: "$1,000.00", imageURL: nil, favouriteImageName: "heart", onTapFavourite: { })
    }
}
#endif

