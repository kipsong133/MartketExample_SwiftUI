//
//  FavoriteProductScrollView.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/03.
//

import SwiftUI

struct FavoriteProductScrollView: View {
    @EnvironmentObject private var store: Store
    @Binding var showingImage: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            title // 뷰의 목적을 표현하는 제목
            if showingImage {
                products
            }
        }
        .padding()
        .transition(.slide)
    }
    
    var title: some View {
        HStack(alignment: .top, spacing: 5) {
            Text("즐겨찾는 상품")
                .font(.headline).fontWeight(.medium)
            
            Symbol("arrowtriangle.up.square")
                .padding(4)
                .rotationEffect(Angle(radians: showingImage ? .pi : 0))
            
            Spacer()
        }
        .padding(.bottom, 8)
        .onTapGesture {
            withAnimation { self.showingImage.toggle() }
        }
    }
    
    var products: some View {
        // 즐겨찾기 상품 목록 읽어 오기
        let favoriteProducts = store.products.filter { $0.isFavorite }
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(favoriteProducts) { product in
                    // 상품 선택 시, 해당 상품에 대한 상세 화면으로 이동하도록 내비게이션 링크로 연결
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        self.eachProduct(product)
                    }
                }
            }
        }
        .animation(.spring(dampingFraction: 0.78), value: store.products)
    }
    
    func eachProduct(_ product: Product) -> some View {
        GeometryReader {
            ResizedImage(product.imageName, renderingMode: .original)
                .clipShape(Circle())
                .frame(width: 90, height: 90)
                .scaleEffect(self.scaledValue(from: $0))
        }
        .frame(width: 105, height: 105)
    }
    
    func scaledValue(from geometry: GeometryProxy) -> CGFloat {
        let xOffset = geometry.frame(in: .global).minX - 16
        let minSize: CGFloat = 0.9
        let maxSize: CGFloat = 1.1
        let delta: CGFloat = maxSize - minSize
        
        let size = minSize + delta * (1 - xOffset / UIScreen.main.bounds.width)
        return max(min(size, maxSize), minSize)
    }
}

struct FavoriteProductScrollView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteProductScrollView(showingImage: .constant(true))
    }
}
