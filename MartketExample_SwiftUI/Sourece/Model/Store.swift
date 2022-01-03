//
//  Store.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/01.
//

import Foundation

final class Store: ObservableObject {
    /* 전체 주문 목록 */
    @Published var orders: [Order] = []
    
    @Published var products: [Product]
    
    func placeOrder(product: Product, quantity: Int) {
        let nextID = Order.orderSequence.next()!
        let order = Order(id: nextID, product: product, quantity: quantity)
        orders.append(order)
    }
    
    init(filename: String = "ProductData.json") {
        self.products = Bundle.main.decode(filename: filename, as: [Product].self)
    }
}

extension Store {
    func toggleFavorite(of product: Product) {
        guard let index = products.firstIndex(of: product) else { return }
        products[index].isFavorite.toggle()
    }
}
