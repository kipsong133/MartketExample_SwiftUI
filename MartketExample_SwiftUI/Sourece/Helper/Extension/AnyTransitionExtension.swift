//
//  AnyTransitionExtension.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/04.
//

import SwiftUI

extension AnyTransition {
    static func stripes() -> AnyTransition {
        // 함수 안에 함수가 있는 형태
        func stripesModifier(stripes: Int = 30,
                             insertion: Bool = true,
                             ratio: CGFloat
        ) -> some ViewModifier {
            let shape = Stripes(stripes: stripes, insertion: insertion, ratio: ratio)
            return ShapeClipModifier(shape: shape)
        }
        
        // 나타날 때, 트랜지션
        let insertion = AnyTransition.modifier(
            active: stripesModifier(ratio: 0),
            identity: stripesModifier(ratio: 1))
        
        // 사라질 때, 트랜지션
        let removal = AnyTransition.modifier(
            active: stripesModifier(ratio: 0),
            identity: stripesModifier(ratio: 1))
        
        // 둘을 합친 트랜지션
        return AnyTransition.asymmetric(
            insertion: insertion,
            removal: removal)
    }
}
