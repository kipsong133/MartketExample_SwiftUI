//
//  Store.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/01.
//

import Foundation

final class Store: ObservableObject {
    /* 전체 주문 목록 */
    @Published var orders: [Order] = [] {
        didSet { saveData(at: ordersFilePath, data: orders)}
    }
    
    @Published var products: [Product]
    
    func placeOrder(product: Product, quantity: Int) {
        let nextID = Order.orderSequence.next()!
        let order = Order(id: nextID, product: product, quantity: quantity)
        Order.lastOrderID = nextID
        orders.append(order)
    }
    
    init(filename: String = "ProductData.json") {
        self.products = Bundle.main.decode(filename: filename, as: [Product].self)
        self.orders = loadData(at: ordersFilePath, type: [Order].self)
    }
}

extension Store {
    func toggleFavorite(of product: Product) {
        guard let index = products.firstIndex(of: product) else { return }
        products[index].isFavorite.toggle()
    }
}

extension Store {
    var ordersFilePath: URL {
        // Library 디렉터리에 있는 ApplicationSupport 디렉터리 URL
        let manager = FileManager.default
        let appSupportDir = manager.urls(for: .applicationSupportDirectory,
                                            in: .userDomainMask).first!
        
        // 번들 ID를 서브 디렉터리로 추가
        let bundleID = Bundle.main.bundleIdentifier ?? "FruitMart"
        let appDir = appSupportDir
            .appendingPathComponent(bundleID, isDirectory: true)
        
        // 디렉터리가 없으면 생성
        if !manager.fileExists(atPath: appDir.path) {
            try? manager.createDirectory(at: appDir,
                                         withIntermediateDirectories: true)
        }
        
        // 지정한 경로에 파일명 추가 - Orders.json
        return appDir
            .appendingPathComponent("Orders")
            .appendingPathExtension("json")
    }
    
    func saveData<T>(at path: URL, data: T) where T: Encodable {
        do {
            let data = try JSONEncoder().encode(data) // 부호화
            try data.write(to: path) // 파일로 저장
        } catch {
            print(error)
        }
    }
    
    func loadData<T>(at path: URL, type: [T].Type) -> [T] where T: Decodable {
        do {
            let data = try Data(contentsOf: path) // 파일 읽어오기
            let decodedData = try JSONDecoder().decode(type, from: data) // 복호화
            return decodedData
        } catch {
            return []
        }
    }
}
