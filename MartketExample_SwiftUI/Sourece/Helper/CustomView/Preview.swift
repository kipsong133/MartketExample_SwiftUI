//
//  Preview.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/02.
//

import SwiftUI

struct Preview<V: View>: View {
    /* 프리뷰에서 활용할 기기 목록 정의 */
    enum Device: String, CaseIterable {
        case iPhone8 = "iPhone 8"
        case iPhone11 = "iPhone 11"
        case iPhone11Pro = "iPhone 11 Pro"
        case iPhone11ProMax = "iPhone 11 Pro Max"
    }
    
    /* 프리뷰에서 표현할 뷰*/
    let source: V
    var devices: [Device] = [.iPhone11Pro, .iPhone11ProMax, .iPhone8]
    /* 다크모드 여부 */
    var displayDarkMode: Bool = true
    
    var body: some View {
        Group {
            ForEach(devices, id:\.self) {
                self.previewSource(device: $0)
            }
            if !devices.isEmpty && displayDarkMode {
                self.previewSource(device: devices[0])
                    .preferredColorScheme(.dark)
            }
        }
    }
    
    private func previewSource(device: Device) -> some View {
        source
            .previewDevice(PreviewDevice(rawValue: device.rawValue)) // 기기 형태
            .previewDisplayName(device.rawValue) // 프리뷰 컨테이너 이름
    }
}

struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: Text("Hello World"))
    }
}
