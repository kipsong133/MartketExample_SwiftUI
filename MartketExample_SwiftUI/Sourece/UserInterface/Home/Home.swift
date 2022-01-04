//
//  Home.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/01.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject private var store: Store
    @State private var quickOrder: Product?
    @State private var showingFavoriteImage: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                if showFavorite {
                    favoriteProducts
                }
                darkerDivider
                productList
            }
            .navigationTitle("과일마트")
        }
        .popupOverContext(item: $quickOrder, style: .blur, content: popupMessage(product:))
    }
    
    var favoriteProducts: some View {
        FavoriteProductScrollView(showingImage: $showingFavoriteImage)
            .padding(.top ,24)
            .padding(.bottom, 8)
    }
    
    var darkerDivider: some View {
        Color.primary
            .opacity(0.3)
            .frame(maxWidth: .infinity, maxHeight: 1)
    }
    
    var productList: some View {
        List {
            ForEach(store.products) { product in
                HStack {
                    ProductRow(quickOrder: $quickOrder, product: product)
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        EmptyView()
                    }.frame(width: 0).opacity(0)
                }
                .listRowBackground(Color.background)
            }
        }
        .background(Color.background)
    }
    
    var showFavorite: Bool { // 즐겨찾기 유무 확인
        !store.products.filter { $0.isFavorite }.isEmpty
    }
    
    func popupMessage(product: Product) -> some View {
        let name = product.name.split(separator: " ").last!
        return VStack {
            Text(name)
                .font(.title).bold().kerning(3)
                .foregroundColor(.peach)
                .padding()
            
            OrderCompletedMessage()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: Home())
            .environmentObject(Store())
    }
}

