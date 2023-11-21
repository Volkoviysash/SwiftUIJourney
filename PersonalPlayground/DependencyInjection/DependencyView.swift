//
//  DependencyView.swift
//  AdvancedLearning
//
//  Created by Alexandr Volkovich on 15.11.2023.
//

import SwiftUI
import Combine

// PROBLEMS with singleton
// 1. Singletons are global (multithreads can break them)
// 2. Can't customize the init!
// 3. Can't swap out dependencies

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostModel], Error>
}

class ProductionDataService: DataServiceProtocol {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    // Get data from API
    func getData() -> AnyPublisher<[PostModel], Error>{
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class MockDataService: DataServiceProtocol {
    let testData: [PostModel]
    
    init(data: [PostModel]?) {
        self.testData = data ??  [
            PostModel(userId: 1, id: 1, title: "One", body: "one"),
            PostModel(userId: 2, id: 2, title: "Two", body: "two"),
            PostModel(userId: 3, id: 3, title: "Three", body: "three"),
        ]
    }
    
    func getData() -> AnyPublisher<[PostModel], Error> {
        Just(testData)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
}

// If u have a lot of dependencies you can make a separate class for them
//class Dependencies {
//    let dataService: DataServiceProtocol
//
//    init(dataService: DataServiceProtocol) {
//        self.dataService = dataService
//    }
//}

class DependencyInjectionViewModel: ObservableObject {
    @Published var dataArray: [PostModel] = []
    var cancellables: Set<AnyCancellable> = []
    let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadPosts()
    }
    
    private func loadPosts() {
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPosts in
                self?.dataArray = returnedPosts
            }
            .store(in: &cancellables)
    }
}

struct DependencyView: View {
    @StateObject private var vm: DependencyInjectionViewModel
    
    init(dataService: DataServiceProtocol) {
        _vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach (vm.dataArray) { post in
                    Text(post.title)
                }
            }
        }
    }
}

struct DependencyView_Preview: PreviewProvider {
    //    static let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    static let dataService = MockDataService(data: [
        PostModel(userId: 123, id: 123, title: "Some test data", body: "some test data")
    ])
    
    static var previews: some View {
        DependencyView(dataService: dataService)
    }
}
