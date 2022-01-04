//
//  Stripes.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/04.
//

import SwiftUI

// View 프로토콜이 아닌 Shape 프로토콜을 채택
struct Stripes: Shape {
    // 줄무늬가 몇 개로 분할되어 보일 것인지 결정. 기본값 30
    var stripes: Int = 30
    var insertion: Bool = true // 삽입, 제거 효과 구분
    var ratio: CGFloat // 화면 차지 비율 0.0 ~ 1.0
    
    /* 어떤 데이터로 애니메이션을 연산할지 결정하는 프로퍼티 */
    var animatableData: CGFloat {
        get { ratio } // 애니메이션 연산에 ratio 활용
        set { ratio = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        // 그림을 그리기 위한 객체 Path 선언
        var path = Path()
        // 줄무늬 하나가 차지하는 너비 기본값 (전체너비 / 줄무늬 개수)
        let stripeWidth = rect.width / CGFloat(stripes)
        
        /*
         * input : 각각의 인덱스값
         * output: 그림을 잘게 쪼갠 것들의 집합
         */
        let rects = (0..<stripes).map { (index: Int) -> CGRect in
            // 줄므늬 시작점 X좌표
            let xOffset = CGFloat(index) * stripeWidth
            // 삽입될 뷰인지 제거될 뷰인지 구분하여 줄무늬 위치 조정
            let adjuestment = insertion ? 0 : (stripeWidth * (1 - ratio))
            return CGRect(
                x: xOffset + adjuestment,
                y: 0,
                width: stripeWidth * ratio,
                height: rect.height
            )
        }
        // 위의 output을 그림 그리기에 추가해서 그린다.
        path.addRects(rects)
        return path
    }

}

extension Stripes: Hashable { } // ForEach에서 데이터 구분을 하기위해 id 매개변수에 값을 전달해야한다. id 매개변수에 전달될 값은 Hashable을 준수해야한다.


struct Stripes_Previews: PreviewProvider {
    static var previews: some View {
        // 화면 전환 비율. 0.1이면, 삽입될 뷰는 10% 제거될 뷰는 90% 가 보이는 상태
        let ratio: [CGFloat] = [0.1, 0.3, 0.5, 0.7, 0.9]
        // 뷰가 삽입되는 과정에서 변화하는 모습을 확인하는 배열
        let insertion = ratio.map { Stripes(ratio: $0) }
        // 뷰가 제거되는 과정에서 변화하는 모습을 확인하는 배열
        let removal = ratio.map {
            Stripes(insertion: false, ratio: 1 - $0)
        }
        
        let image = ResizedImage(recipeSamples[0].imageName,
                                 contentMode: .fit)
        
        return HStack {
            ForEach([insertion, removal], id: \.self) { type in
                VStack {
                    ForEach(type, id: \.self) {
                        image.modifier(ShapeClipModifier(shape: $0))
                    }
                }
            }
        }
    }
}
