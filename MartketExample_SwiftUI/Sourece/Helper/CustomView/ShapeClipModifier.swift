//
//  ShapeClipModifier.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/04.
//

import SwiftUI

/*
 * Input: Shape
 * Output: View
 */
struct ShapeClipModifier<S: Shape>: ViewModifier {
    let shape: S
    
    func body(content: Content) -> some View {
        content
            .clipShape(shape)
    }
    
}

//struct ShapeClipModifier_Previews: PreviewProvider {
//    static var previews: some View {
//        ShapeClipModifier()
//    }
//}
