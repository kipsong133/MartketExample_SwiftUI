//
//  Home.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/01.
//

import SwiftUI

struct Home: View {
    let store: Store
    
    var body: some View {
        List(store.products, id:\.name) { product in
            ProductRow(product: product)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(store: Store())
    }
}

