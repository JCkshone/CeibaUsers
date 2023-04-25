//
//  UsersReducer.swift
//  ceiba-users
//
//  Created by Juan Camilo Navarro on 24/04/23.
//
import Foundation

enum UsersReducer {
    static func reduce(state: inout UsersState, action: UsersAction) {
        switch action {
        case .loadUsers:
            state = .loading
            
        case let .loadUsersSuccess(users):
            state = .loaded(users)
            
        case let .loadUsersFailure(error):
            state = .withError(error)
            
        case .loadPosts:
            state = .loadingPost
            
        case let .loadPostsSuccess(posts):
            state = .loadedPost(posts)
            
        case let .loadPostsFailure(error):
            state = .withError(error)
            
        }
    }
}
