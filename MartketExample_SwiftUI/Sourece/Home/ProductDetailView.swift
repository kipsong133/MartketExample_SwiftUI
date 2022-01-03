//
//  ProductDetailView.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/01.
//

import SwiftUI

struct ProductDetailView: View {
    @State private var quantity: Int = 1
    @State private var showingAlert: Bool = false
    @EnvironmentObject private var store: Store
    @State private var showingPopup: Bool = false
    
    let product: Product
    
    var body: some View {
        VStack(spacing: 0) {
            productImage
            orderView
        }
        .popup(
            isPresented: $showingPopup,
            style: .blur,
            content: { OrderCompletedMessage() })
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $showingAlert) {
            confirmAlert
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let source1 = ProductDetailView(product: productSamples[0])
        let source2 = ProductDetailView(product: productSamples[1])
        return Group {
            // 나머지 매개 변수 생략 시, 총 4 가지 환경에서 프리뷰 출력
            Preview(source: source1)
            // iPhone 11 Pro + 라이트 모드 - 1 가지 환경에서만 출력
            Preview(source: source2, devices: [.iPhone11Pro], displayDarkMode: false)
        }
    }
}

private extension ProductDetailView {
    var productImage: some View {
        GeometryReader { _ in
            ResizedImage(self.product.imageName)
        }
    }
    
    var orderView: some View {
        GeometryReader {
            VStack(alignment: .leading) {
                self.productDescription
                Spacer()
                self.priceInfo
                self.placeOrderButton
                    .padding(.bottom, 5)
            }
            .frame(height: $0.size.height + 10)
            .padding(32)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
            
        }
    }
    
    var productDescription: some View {
        VStack(alignment: .leading, spacing: 17) {
            HStack {
                Text(product.name)
                    .font(.largeTitle).fontWeight(.medium)
                    .foregroundColor(.black)
                
                Spacer()
                
               FavoriteButton(product: product)
            }
            
            Text(splitText(product.description))
                .foregroundColor(.secondaryText)
                .fixedSize()
        }
    }
    
    func splitText(_ text: String) -> String {
      guard !text.isEmpty else { return text }
      let centerIdx = text.index(text.startIndex, offsetBy: text.count / 2)
      let centerSpaceIdx = text[..<centerIdx].lastIndex(of: " ")
        ?? text[centerIdx...].firstIndex(of: " ")
        ?? text.index(before: text.endIndex)
      let afterSpaceIdx = text.index(after: centerSpaceIdx)
      let lhsString = text[..<afterSpaceIdx].trimmingCharacters(in: .whitespaces)
      let rhsString = text[afterSpaceIdx...].trimmingCharacters(in: .whitespaces)
      return String(lhsString + "\n" + rhsString)
    }
    
    var priceInfo: some View {
        HStack {
            (Text("₩")
            + Text("\(product.price)").font(.title)
            ).fontWeight(.medium)
            Spacer()
            QuantitySelector(quantity: $quantity)
        }
        .foregroundColor(.black)
    }
    
    var placeOrderButton: some View {
        Button(action: {
            self.showingAlert = true
        }, label: {
            Capsule()
                .fill(Color.peach)
                .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 55)
                .overlay(Text("주문하기")
                            .font(.system(size: 20)).fontWeight(.medium)
                            .foregroundColor(.white))
                .padding(.vertical, 8)
        })
            .buttonStyle(ShrinkButtonStyle())
    }
    
    var confirmAlert: Alert {
        Alert(
            title: Text("주문 확인"),
            message: Text("\(product.name)을(를) \(quantity)개 구매하시겠습니까?"),
            primaryButton: .default(Text("확인"), action: {
                // 주문 기능 구현
                self.placeOrder()
            }), secondaryButton: .cancel(Text("취소")))
    }
    
    func placeOrder() {
        store.placeOrder(product: product, quantity: quantity)
        showingPopup = true
    }
}
