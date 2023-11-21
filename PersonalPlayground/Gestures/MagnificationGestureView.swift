//
//  MagnificationGestureView.swift
//  AdvancedLearning
//
//  Created by Alexandr Volkovich on 17.11.2023.
//

import SwiftUI

struct MagnificationGestureView: View {
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        Text("Hello, World!")
            .font(.title)
            .padding(40)
            .background(Color.red.cornerRadius(10))
            .scaleEffect(1.0 + currentAmount + lastAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged({ value in
                        currentAmount = value - 1
                    })
                    .onEnded({ value in
                        lastAmount += currentAmount
                        currentAmount = 0
                    })
            )
    }
}


struct MagnificationUpdatedGestureView: View {
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Circle().frame(width: 35, height: 35)
                
                Text("Swiftful thinking")
                
                Spacer()
                
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(MagnificationGesture()
                    .onChanged{ value in
                        currentAmount = value - 1
                    }
                    .onEnded({ value in
                        withAnimation(.spring()){
                            currentAmount = 0
                        }
                    })
                )
            
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            Text(" This is the caption.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
}


struct MagnificationGestureView_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationUpdatedGestureView()
    }
}
