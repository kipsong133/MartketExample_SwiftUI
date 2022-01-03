//
//  Home.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/01.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject private var store: Store
    
    var body: some View {
        NavigationView {
            List(store.products) { product in
                NavigationLink(destination: ProductDetailView(product: product), label: {
                    ProductRow(product: product)
                })
                    
            }
            .navigationTitle("과일마트")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: Home())
            .environmentObject(Store())
    }
}

