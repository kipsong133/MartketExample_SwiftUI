//
//  MartketExample_SwiftUIApp.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/01.
//

import SwiftUI

@main
struct MartketExample_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(Store())
                .onAppear {
                    configureAppearance()
                }
        }
    }
    
    private func configureAppearance() {
        // large 디스플레이 모드에서 적용
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(named: "peach")!
        ]
        
        // inline 디스플레이 모드일 때 적용
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(named: "peach")!
        ]
        
        // clear or nil 로 결정
        UITableView.appearance().backgroundColor = .clear
        
        UISlider.appearance().thumbTintColor = UIColor(named: "peach")
    }
}
