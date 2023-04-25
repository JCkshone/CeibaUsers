//
//  AppEnum.swift
//  ceiba-users
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import Foundation

public protocol PathDefinitionProtocol {
    associatedtype Path
    var description: String { get }
}


public enum HttpMethod: String {
    case get    = "GET"
}

public enum AppError {
    enum Api: Error {
        case invalidUrl(url: String)
        case undefined
        case noInternet
        case invalidResponse
        case timeOut
        case invalidDecodableModel
        case invalidObject
        case serverError(ErrorMessageResponse)
        
        var message: String {
            if case let .serverError(error) = self {
                return error.message
            }
            if case .noInternet = self {
                return "Revisa tu conexión a internet e intenta más tarde"
            }
            return .empty
        }
    }
    
    enum DataMapper: Error {
        case invalidMapper
    }
}

public enum PathsDefinition {
    
    public enum Users: String {
        case users = "users"
        case posts = "users/%d/posts"
    }
}

public enum UsersPath: PathDefinitionProtocol {
    public typealias Path = PathsDefinition.Users
    
    case path(Path, [Int])
    
    public var description: String {
        if case let .path(path, int) = self {
            return String(format: path.rawValue, int.first ?? .zero)
        }
        return .empty
    }
}
