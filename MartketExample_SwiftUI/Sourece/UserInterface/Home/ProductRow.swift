//
//  ProductRow.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/01.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var store: Store
    @Binding var quickOrder: Product?
    
    let product: Product
    
    var body: some View {
        HStack {
            // 상품 이미지
            productImage
            productDescription
        }
        .frame(height: 150)
        .background(Color.primary.colorInvert())
        .cornerRadius(6)
        .shadow(color: Color.secondaryText, radius: 1, x: 2, y: 2)
        .padding(.vertical, 8)
    }
}

private extension ProductRow {
    var productImage: some View {
        Image(product.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 140)
            .clipped()
    }
    
    var footView: some View {
        HStack(spacing: 0) {
            // 가격정보와 버튼
            Text("₩").font(.footnote)
            + Text("\(product.price)").font(.headline)
            
            Spacer()
            
            FavoriteButton(product: product)
            
            Image(systemName: "cart")
                .foregroundColor(Color.peach)
                .frame(width: 23, height: 32)
                .onTapGesture {
                    self.orderProduct()
                }
            
        }
    }
    
    
    var productDescription: some View {
        
        VStack(alignment: .leading) {
            // 상품명
            Text(product.name)
                .font(.headline)
                .fontWeight(.medium)
                .padding(.bottom, 6)
            // 상품설명
            Text(product.description)
                .font(.footnote)
                .foregroundColor(.secondaryText)
            Spacer()
            footView
        }
        .padding([.leading, .bottom], 12)
        .padding([.top, .trailing])
        
    }
    
    func orderProduct() {
        quickOrder = product
        store.placeOrder(product: product, quantity: 1)
    }
}


struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(productSamples) {
                ProductRow(quickOrder: .constant(nil), product: $0)
            }
            ProductRow(quickOrder: .constant(nil), product: productSamples[0])
                .preferredColorScheme(.dark)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

