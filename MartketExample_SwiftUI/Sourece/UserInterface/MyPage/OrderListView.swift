//
//  OrderListView.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/04.
//

import SwiftUI

struct OrderListView: View {
    @EnvironmentObject var store: Store
    @State private var showingView: Bool = true
    
    var body: some View {
        ZStack {
            if store.orders.isEmpty {
                emptyOrders
            } else {
                orderList
            }
        }
        .animation(.default)
        .navigationBarTitle("주문 목록")
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
    }
}

fileprivate extension OrderListView {
    var emptyOrders: some View {
        VStack(spacing: 25) {
            Image("box")
                .renderingMode(.template)
                .foregroundColor(.gray.opacity(0.4))
            Text("주문 내역이 없습니다.")
                .font(.headline).fontWeight(.medium)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
    
    var orderList: some View {
        List {
            ForEach(store.orders) {
                OrderRow(order: $0)
            }
        }
    }
}
