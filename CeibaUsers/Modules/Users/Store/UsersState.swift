//
//  UsersState.swift
//  ceiba-users
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import Foundation

enum UsersState {
    case neverLoaded
    case loading
    case loaded([UserModel])
    
    case loadingPost
    case loadedPost([PostModel])
    case withError(Error)
}
