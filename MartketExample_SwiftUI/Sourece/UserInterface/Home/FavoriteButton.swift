//
//  FavoriteButton.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/02.
//

import SwiftUI

struct FavoriteButton: View {
    @EnvironmentObject private var store: Store
    let product: Product
    
    private var imageName: String {
        product.isFavorite ? "heart.fill" : "heart"
    }
    
    var body: some View {
        Symbol(imageName, scale: .large, color: .peach)
            .frame(width: 32, height: 32)
            .onTapGesture {
                withAnimation {
                    self.store.toggleFavorite(of: product)
                }
            }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(product: productSamples[0])
    }
}
