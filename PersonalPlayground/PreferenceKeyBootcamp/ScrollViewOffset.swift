//
//  ScrollViewOffset.swift
//  AdvancedLearning
//
//  Created by Alexandr Volkovich on 07.11.2023.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func onScrollViewOffsetChanged(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self
            .background(GeometryReader { geo in
                Text("")
                    .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
            })
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self, perform: { value in
                action(value)
            })
    }
}

struct ScrollViewOffset: View {
    let title: String = "New Title!!!"
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack {
                titleLayer
                    .opacity(Double(scrollViewOffset) / 59.0)
                    .onScrollViewOffsetChanged { value in
                        self.scrollViewOffset = value
                    }
                
                contentLayer
            }
        }
        .overlay(Text("\(scrollViewOffset)").foregroundColor(.black))
        .overlay( navBarLayer.opacity(scrollViewOffset < 40 ? 1.0 : 0.0),
                  alignment: .top )
    }
}

extension ScrollViewOffset {
    private var titleLayer: some View {
        Text("Hello, world!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    private var contentLayer: some View {
        ForEach(0..<30) { _ in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
                .frame(width: 300, height: 200)
        }
    }
    
    private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.blue)
    }
}

struct ScrollViewOffset_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOffset()
    }
}
