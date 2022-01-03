//
//  Popup.swift
//  MartketExample_SwiftUI
//
//  Created by 김우성 on 2022/01/03.
//

import SwiftUI

enum PopupStyle {
    case none
    case blur
    case dimmed
}

struct Popup<Message: View>: ViewModifier {
    let size: CGSize? // 팝업창 크기
    let style: PopupStyle // enum
    let message: Message // 팝업창에 전달할 메세지
    
    init(
        size: CGSize? = nil,
        style: PopupStyle = .none,
        message: Message)
    {
        self.size = size
        self.style = style
        self.message = message
    }
    
    func body(content: Content) -> some View {
        content
            .blur(radius: style == .blur ? 2 : 0)
            .overlay(Rectangle() // dimmed style 에만 적용할 수식어
                        .fill(Color.black.opacity(style == .dimmed ? 0.4 : 0)))
            .overlay(popupContent) // 팝업창으로 펴현될 뷰
    }
    
    private var popupContent: some View {
        GeometryReader {
            VStack { self.message } // 팝업창에 표시할 메시지
            .frame(width: self.size?.width ?? $0.size.width * 0.6,
                   height: self.size?.height ?? $0.size.height * 0.25)
            .background(Color.primary.colorInvert())
            .cornerRadius(12)
            .shadow(color: .primaryShadow, radius: 15, x: 5, y: 5)
            .overlay(self.checkCircleMark, alignment: .top)
            // iOS 13과 iOS 14의 지오메트리 리더 뷰 정렬 위치가 달라졌으므로 조정
            .position(x: $0.size.width / 2, y: $0.size.height / 2)
        }
    }
    
    /* 팝업 상단에 위치한 체크 마크 심벌 */
    private var checkCircleMark: some View {
        Symbol("checkmark.circle.fill", color: .peach)
            .font(.system(size: 60, weight: .semibold))
            .background(Color.white.scaleEffect(0.8)) // 체크 마크 배경색을 흰색으로 지정
            .offset(x: 0, y: -20) // 팝업 상단에 걸쳐지도록 원래 위치보다 위로 조정
    }
}

fileprivate struct PopupToggle: ViewModifier {
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
        // disabled 수식어로 인해, false의 경우 모든 상호작용 무시한다.
        // 만약 뒤에 onTapGesture가 있다면, 해당 제스처만 인식하게 된다.(반드시 뒤에해야 인식함)
            .disabled(isPresented)
            .onTapGesture {
                self.isPresented.toggle()
            }
    }
}

extension View {
    func popup<Content: View>(
        isPresented: Binding<Bool>,
        size: CGSize? = nil,
        style: PopupStyle = .none,
        @ViewBuilder content: () -> Content
    ) -> some View {
        if isPresented.wrappedValue {
            let popup = Popup(size: size, style: style, message: content())
            let popupToggle = PopupToggle(isPresented: isPresented)
            let modifiedContent = self.modifier(popup).modifier(popupToggle)
            return AnyView(modifiedContent) // 불투명 타입으로 리턴하는 경우 이렇게 작성한다.
        } else {
            return AnyView(self)
        }
    }
}

fileprivate struct PopupItem<Item: Identifiable>: ViewModifier {
    @Binding var item: Item?
    func body(content: Content) -> some View {
        content
            .disabled(item != nil)
            .onTapGesture {
                self.item = nil
            }
    }
}

extension View {
    fileprivate func popup<Content: View, Item: Identifiable>(
        item: Binding<Item?>,
        size: CGSize? = nil,
        style: PopupStyle = .none,
        @ViewBuilder content: (Item) -> Content
    ) -> some View {
        if let selectedItem = item.wrappedValue {
            let content = content(selectedItem)
            let popup = Popup(size: size, style: style, message: content)
            let popupItem = PopupItem(item: item)
            let modifiedContent = self.modifier(popup).modifier(popupItem)
            return AnyView(modifiedContent)
        } else {
            return AnyView(self)
        }
    }
    
    func popupOverContext<Item: Identifiable, Content: View>(
      item: Binding<Item?>,
      size: CGSize? = nil,
      style: PopupStyle = .none,
      ignoringEdges edges: Edge.Set = .all,
      @ViewBuilder content: (Item) -> Content
    ) -> some View  {
      let isNonNil = item.wrappedValue != nil
      return ZStack {
        self // 현재 있는 콘텍스트 위에 두어야하므로 self를 추가한다.
          .blur(radius: isNonNil && style == .blur ? 2 : 0)
        
        if isNonNil {
          Color.black
            .luminanceToAlpha() // 휘도와 투명도를 연결하는 수식어
            .popup(item: item, size: size, style: style, content: content)
            .edgesIgnoringSafeArea(edges)
        }
      }
    }
}
