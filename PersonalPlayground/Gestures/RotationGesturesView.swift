//
//  RotationGesturesView.swift
//  AdvancedLearning
//
//  Created by Alexandr Volkovich on 17.11.2023.
//

import SwiftUI

struct RotationGesturesView: View {
    @State var angle: Angle = Angle(degrees: 0)
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(50)
            .background(.blue)
            .cornerRadius(10)
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged({ value in
                        angle = value
                    })
                    .onEnded({ value in
                        withAnimation(.spring()) {
                            angle = Angle(degrees: 0)
                        }
                    })
            )
    }
}

struct RotationGesturesView_Previews: PreviewProvider {
    static var previews: some View {
        RotationGesturesView()
    }
}
