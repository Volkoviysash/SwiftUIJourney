//
//  Coordinator.swift
//  AdvancedLearning
//
//  Created by Alexandr Volkovich on 13.11.2023.
//

import SwiftUI

struct CoordinatorView: View {
    
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .apple)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(sheet: sheet)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreenCover in
                    coordinator.build(fullScreenCover: fullScreenCover)
                }
        }
        .environmentObject(coordinator)
    }
}

struct AppleView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        List {
            Button("Push to banana") {
                coordinator.push(.banana)
            }
            
            Button("Present Lemon") {
                coordinator.present(.lemon)
            }
            
            Button("Present olive") {
                coordinator.present(.olive)
            }
        }
        .navigationTitle("Apple")
    }
}

struct BananaView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        List {
            Button("Push to carrot") {
                coordinator.push(.carrot)
            }
            
            Button("Pop") {
                coordinator.pop()
            }
        }
        .navigationTitle("Banana")
    }
}

struct CarrotView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack {
            Text("Carrot sheet")
            
            Button("Pop") {
                coordinator.pop()
            }
            
            Button("Pop to root") {
                coordinator.popToRoot()
            }
        }
    }
}

struct LemonView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack {
            Text("Lemon")
            Button("Dismiss") {
                coordinator.dismissSheet()
            }
        }
    }
}

struct OliveView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack {
            Text("Olive")
            Button("Dismiss") {
                coordinator.dismissFullScreenCover()
            }
        }
    }
}

struct Coordinator_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatorView()
    }
}
