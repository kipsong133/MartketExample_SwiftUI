//
//  Order.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/03.
//

import Foundation

struct Order: Identifiable {
    static var orderSequence = sequence(first: 1) { $0 + 1 }
    
    let id: Int
    let product: Product
    let quantity: Int
    
    var price: Int {
        product.price * quantity
    }
}
