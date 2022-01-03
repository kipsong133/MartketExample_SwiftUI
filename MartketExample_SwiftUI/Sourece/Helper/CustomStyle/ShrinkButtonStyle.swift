//
//  ShrinkButtonStyle.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/03.
//

import SwiftUI

struct ShrinkButtonStyle: ButtonStyle {
    // 버튼이 눌리고 있을 때, 변화할 크기와 투명도 지정
    var minScale: CGFloat = 0.9
    var minOpacity: Double = 0.6
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label // <- 기본 버튼 UI
            .scaleEffect(configuration.isPressed ? minScale : 1) // <- 여기서부터 커스텀
            .opacity(configuration.isPressed ? minOpacity : 1)
    }
}
