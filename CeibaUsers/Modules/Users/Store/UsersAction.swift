//
//  UsersAction.swift
//  ceiba-users
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import Foundation

enum UsersAction {
    case loadUsers
    case loadUsersSuccess(_ response: [UserModel])
    case loadUsersFailure(_ error: Error)
    
    case loadPosts(userId: Int)
    case loadPostsSuccess(_ response: [PostModel])
    case loadPostsFailure(_ error: Error)
}
