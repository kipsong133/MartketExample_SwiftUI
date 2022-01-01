//
//  Store.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/01.
//

import Foundation

final class Store {
    var products: [Product]
    
    init(filename: String = "ProductData.json") {
        self.products = Bundle.main.decode(filename: filename, as: [Product].self)
    }
}
