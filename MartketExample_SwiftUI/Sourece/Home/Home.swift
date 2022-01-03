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
    
    var body: some View {
        NavigationView {
            List(store.products) { product in
                NavigationLink(destination: ProductDetailView(product: product), label: {
                    ProductRow(quickOrder: $quickOrder, product: product)
                })
            }
            .navigationTitle("과일마트")
        }
        .popupOverContext(item: $quickOrder, style: .blur, content: popupMessage(product:))
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

