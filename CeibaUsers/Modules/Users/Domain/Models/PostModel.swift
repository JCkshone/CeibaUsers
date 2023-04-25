//
//  PostModel.swift
//  ceiba-users
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import Foundation

struct PostModel: Decodable, Identifiable {
    let id: Int
    let title: String
    let body: String
}
