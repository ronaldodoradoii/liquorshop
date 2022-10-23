//
//  ProductDetailView.swift
//  LiquorShop
//
//  Created by RD on 23/10/22.
//

import SwiftUI
import URLImage

struct ProductDetailView: View {
    @StateObject private var viewModel: ProductDetailViewModel

    init(viewModel: ProductDetailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .center) {
                if let imageURL = viewModel.imageURL {
                    URLImage(imageURL,
                             content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: CustomSize.productDetailImage, height: CustomSize.productDetailImage, alignment: .center)
                    })
                } else {
                    Color.gray
                        .frame(width: CustomSize.productDetailImage, height: CustomSize.productDetailImage)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, CustomSize.large)
            
            Text(viewModel.productTitle)
                .font(Font.title3.weight(.semibold))
                .padding(.bottom, CustomSize.medium)
            Text(viewModel.price)
                .foregroundColor(.gray)
                .padding(.bottom, CustomSize.medium)
            Text("\(NSDecimalNumber(decimal: viewModel.ratingCount))")
            Spacer()
            Button(action: {
                viewModel.toggleFavourites()
            }, label: {
                HStack {
                    Text("Add to favouriites")
                        .font(.system(size: CustomSize.buttonFontSize))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: viewModel.favouriteImage)
                        .font(.system(size: CustomSize.buttonFontSize))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, CustomSize.large)
                .padding(.vertical, CustomSize.medium)
            })
            .background(Color.blue)
            .cornerRadius(CustomSize.buttonCornerRadius)
            .frame(maxWidth: .infinity, idealHeight: 80
            )
            Spacer().frame(maxHeight: CustomSize.spaceFromBottomEdge)
        }
        .navigationTitle("Product Detail")
        .padding(CustomSize.large)
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            viewModel.refresh()
        }
    }
}

#if DEBUG
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProductDetailViewModel(favouritesStore: FavouritesStoreStub(),
                                               id: "1",
                                               productTitle: "Some product name",
                                               price: "$123.40",
                                               ratingCount: 5.0,
                                               imageURL: nil)
        ProductDetailView(viewModel: viewModel)
    }
}
#endif

