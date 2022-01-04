//
//  MyPage.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/04.
//

import SwiftUI

struct MyPage: View {
    var body: some View {
        NavigationView {
            Form {
                orderInfoSection
            }
            .navigationBarTitle("마이페이지")
        }
    }
}

struct MyPage_Previews: PreviewProvider {
    static var previews: some View {
        MyPage()
    }
}

fileprivate extension MyPage {
    var orderInfoSection: some View {
        Section(content: {
            NavigationLink(destination: OrderListView()) {
                Text("주문 목록")
            }
            .frame(height: 44)
        }, header: {
            Text("주문 정보")
        })
    }
}
