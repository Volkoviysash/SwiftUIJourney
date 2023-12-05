//
//  HashableView.swift
//  PersonalPlayground
//
//  Created by Alexandr Volkovich on 05.12.2023.
//

import SwiftUI

// To put objects in foreach we should make an id for each of them or we can add Hashable protocol which makes them unique id

struct MyCustomModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashableView: View {
    let data: [MyCustomModel] = [
        MyCustomModel(title: "One"),
        MyCustomModel(title: "Two"),
        MyCustomModel(title: "Three"),
        MyCustomModel(title: "Four"),
        MyCustomModel(title: "Five"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ForEach(data, id:\.self) { item in
                    Text(item.hashValue.description)
                        .font(.headline)
                }
            }
        }
    }
}

struct HashableView_Previews: PreviewProvider {
    static var previews: some View {
        HashableView()
    }
}
