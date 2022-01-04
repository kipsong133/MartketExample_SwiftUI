//
//  OrderRow.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/04.
//

import SwiftUI

struct OrderRow: View {
    let order: Order
    
    var body: some View {
        HStack {
            ResizedImage(order.product.imageName)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text(order.product.name)
                    .font(.headline).fontWeight(.medium)
                    
                Text("₩\(order.price)  |  \(order.quantity)개")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .frame(height: 100)
    }
}

//struct OrderRow_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderRow(order: )
//    }
//}
