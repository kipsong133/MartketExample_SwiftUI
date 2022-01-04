//
//  FruitCard.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/04.
//

import SwiftUI

struct FruitCard: View {
    let imageName: String
    let size: CGSize
    let cornerRadius: CGFloat
    
    init(
        _ imageName: String,
        size: CGSize = CGSize(width: 240, height: 200),
        cornerRadius: CGFloat = 14) {
            self.imageName = imageName
            self.size = size
            self.cornerRadius = cornerRadius
        }
    
    var body: some View {
        ResizedImage(imageName)
            .frame(width: size.width, height: size.height)
            .cornerRadius(cornerRadius)
    }
}

struct FruitCard_Previews: PreviewProvider {
    static var previews: some View {
        FruitCard(productSamples[0].imageName)
    }
}
