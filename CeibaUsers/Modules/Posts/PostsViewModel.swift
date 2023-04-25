//
//  PostsViewModel.swift
//  CeibaUsers
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import Foundation
import Resolver
import Combine

class PostsViewModel: ObservableObject {
    @Injected private var store: Store<UsersState, UsersAction>
    
    @Published var isLoading: Bool = true
    @Published var posts: [PostModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func viewDidLoad() {
        suscribers()
    }
    
    func dispatchLoadPost(with userId: Int) {
        store.dispatch(.loadPosts(userId: userId))
    }
}

extension PostsViewModel {
    func suscribers() {
        store.$state.sink { [weak self] state in
            guard let self = self else { return }
            if case .loadingPost  = state {
                self.isLoading = true
            }
            if case let .loadedPost(posts) = state {
                self.posts = posts
            }
        }.store(in: &cancellables)
    }
}
