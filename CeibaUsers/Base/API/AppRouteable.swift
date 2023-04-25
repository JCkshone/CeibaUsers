//
//  AppRouteable.swift
//  ceiba-users
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import Foundation
import Resolver

public typealias HttpHeaders = [String: String]
public typealias HttpQueryParams = [String: String]

public protocol BaseUrl {
    var baseUrl: URL { get }
}

struct ErrorMessageResponse: Decodable {
    let message: String
}

public struct ApiErrorResponse<T: Decodable>: Decodable {
    public let error: T
    
    enum CodingKeys: String, CodingKey {
        case error
    }
}

public struct ApiResponse<T: Decodable>: Decodable {
    public let response: T
    
    enum CodingKeys: String, CodingKey {
        case response = "data"
    }
}

public protocol AppRoutable: BaseUrl {
    var path: any PathDefinitionProtocol { get }
    var queryParams: HttpQueryParams { get }
    var method: HttpMethod { get }
}

public extension AppRoutable {
    var queryParams: HttpQueryParams { [:] }
    var aditionalHeaders: HttpHeaders { [:] }
    
    var baseUrl: URL {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com") else { fatalError("Base url could not be configured.") }
        return url
    }
    
    var headers: HttpHeaders {
        return [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json; charset=utf-8",
        ]
    }
    
    func buildRequest() throws -> URLRequest {
        var urlRequest = URLRequest(
            url: buildUrl()
        )
        urlRequest.httpMethod = method.rawValue
        
        headers.forEach { header in
            urlRequest.setValue(
                header.value,
                forHTTPHeaderField: header.key
            )
        }
        
        aditionalHeaders.forEach { aditionalHeader in
            urlRequest.setValue(
                aditionalHeader.value,
                forHTTPHeaderField: aditionalHeader.key
            )
        }
        return urlRequest
    }

}


extension AppRoutable {
    func buildUrl() -> URL {
        guard let url = URL(
            string: baseUrl.appendingPathComponent(
                "/\(path.description)"
            ).description
        ) else {
            return URL(fileURLWithPath: .empty)
        }
        
        var urlComponents = URLComponents(
            url: url,
            resolvingAgainstBaseURL: true
        )
        
        urlComponents?.queryItems = queryParams.compactMap {
            return URLQueryItem(
                name: $0.key, value: $0.value
            )
        }
        
        return urlComponents?.url ?? URL(fileURLWithPath: .empty)
    }
}

extension Data {
    func print() throws {
        guard let json = try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] else {
            return
        }
        debugPrint("[HTTP RESPONSE] ", json)
    }
}

extension String {
    static let empty = ""
}
