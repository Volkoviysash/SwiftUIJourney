//
//  GeometryReader.swift
//  AdvancedLearning
//
//  Created by Alexandr Volkovich on 17.11.2023.
//

// MARK: - Geometry tells how much size takes a content inside it

import SwiftUI

struct GeometryReaderView: View {
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false, content: {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 40),
                                axis: (x: 0, y: 1.0, z: 0))
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        })
        
//        GeometryReader { geometry in
//            HStack(spacing: 0) {
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: geometry.size.width * 0.6)
//
//                Rectangle()
//                    .fill(Color.blue)
//            }
//        }
    }
}

struct GeometryReader_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderView()
    }
}
