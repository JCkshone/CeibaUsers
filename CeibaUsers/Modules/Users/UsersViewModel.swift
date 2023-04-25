//
//  UsersViewModel.swift
//  CeibaUsers
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import Foundation
import Resolver
import Combine

final class UsersViewModel: ObservableObject {
    @Injected private var store: Store<UsersState, UsersAction>
    @Published var isLoading: Bool = true
    @Published var users: [UserModel] = []
    @Published var search: String = .empty
    private var originalUsersData: [UserModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func viewDidLoad() {
        suscribers()
        dispatchLoadUsers()
    }
    
    func dispatchLoadUsers() {
        store.dispatch(.loadUsers)
    }
}

extension UsersViewModel {
    func suscribers() {
        store.$state.sink { [weak self] state in
            guard let self = self else { return }
            if case .loading  = state {
                self.isLoading = true
            }
            if case let .loaded(users) = state {
                self.users = users
                self.originalUsersData = users
            }
        }.store(in: &cancellables)
        
        $search
            .map { [self] value in
                if value.count > 3 || value.isEmpty {
                    return originalUsersData
                }
                return originalUsersData.filter { $0.name.contains(value) }
            }
            .assign(to: \.users, on: self)
            .store(in: &cancellables)
    }
}
