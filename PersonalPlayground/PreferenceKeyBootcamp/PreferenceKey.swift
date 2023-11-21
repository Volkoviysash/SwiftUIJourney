//
//  PreferenceKey.swift
//  AdvancedLearning
//
//  Created by Alexandr Volkovich on 07.11.2023.
//

// It uses for up some state from child to it's parent

import SwiftUI

struct PreferenceKeyView: View {
    @State private var text: String = "Hello!"
    
    var body: some View {
        NavigationView{
            VStack {
                SecondaryScreen(text: text)
                    .navigationTitle("Navigation Title")
                    .customTitle("New custom title")
            }
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self , perform: { value in
            self.text = value
        })
    }
}

struct SecondaryScreen: View {
    let text: String
    @State private var newValue: String = ""
    
    var body: some View {
        Text(text)
            .onAppear(perform: getDataFromDatabase)
            .customTitle(newValue)
    }
    
    func getDataFromDatabase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newValue = "New Value"
        }
    }
}

struct CustomTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

extension View {
    func customTitle(_ text: String) -> some View {
        preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}


struct PreferenceKey_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceKeyView()
    }
}


