//
//  Home.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/01.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack {
            ProductRow(product: productSamples[0])
            ProductRow(product: productSamples[1])
            ProductRow(product: productSamples[2])
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

