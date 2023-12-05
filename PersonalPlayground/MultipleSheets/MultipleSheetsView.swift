//
//  MultipleSheetsView.swift
//  PersonalPlayground
//
//  Created by Alexandr Volkovich on 30.11.2023.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

// Logic inside sheet doesn't work because sheet renders when view prints before appearing

// use - Binding selectedModel in NextView
// use - multiple .sheets - so for each of cases should be a separate sheet
// ise - $item - the best practicies

struct MultipleSheetsView: View {
    @State var selectedModel: RandomModel?
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                selectedModel = RandomModel(title: "ONE")
            }
            
            Button("Button 2") {
                selectedModel = RandomModel(title: "TWO")
            }
        }
        .sheet(item: $selectedModel) { model in
            NextView(selectedModel: model)
        }
    }
}

struct NextView: View {
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct MultipleSheetsView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsView()
    }
}
