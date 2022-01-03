//
//  Symbol.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/03.
//

import SwiftUI

struct Symbol: View {
    let systemName: String
    let imageScale: Image.Scale
    let color: Color?
    
    init(
        _ systemName: String,
        scale imageScale: Image.Scale = .medium,
        color: Color? = nil) {
            self.systemName = systemName
            self.imageScale = imageScale
            self.color = color
        }
    
    
    var body: some View {
        Image(systemName: systemName)
            .imageScale(imageScale)
            .foregroundColor(color)
    }
}
//
//struct Symbol_Previews: PreviewProvider {
//    static var previews: some View {
//        Symbol()
//    }
//}
