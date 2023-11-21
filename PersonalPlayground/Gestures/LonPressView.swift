//
//  LonPressView.swift
//  AdvancedLearning
//
//  Created by Alexandr Volkovich on 17.11.2023.
//

import SwiftUI

struct LonPressView: View {
    @State var isCompleted: Bool = false
    
    var body: some View {
        Text(isCompleted ? "COMPLETED" : "NOT COMPLETED")
            .padding()
            .padding(.horizontal)
            .background(isCompleted ? .green : .gray)
            .cornerRadius(10)
        //            .onTapGesture {
        //                isCompleted.toggle()
        //            }
            .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 10) {
                isCompleted.toggle()
            }
    }
}

struct LonPressGestureView: View {
    @State var isCompleted: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isCompleted ? .infinity : 0)
                .frame(height: 50)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack(spacing: 50) {
                Text("Click Here")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50, pressing: { isPressing in
                        // From start of press to min duration
                        if isPressing {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isCompleted = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut) {
                                        isCompleted = false
                                    }
                                }
                            }
                        }
                    }) {
                        // At the minimum duration
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                    }
                
                Text("Reset")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isCompleted = false
                        isSuccess = false
                    }
            }
        }
    }
}

struct LonPressView_Previews: PreviewProvider {
    static var previews: some View {
        // LonPressView()
        LonPressGestureView()
    }
}
