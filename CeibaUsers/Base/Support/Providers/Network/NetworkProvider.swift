//
//  NetworkProvider.swift
//  ceiba-users
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import Foundation

protocol NetworkProviderProtocol {
    var agent: NetworkAgentProtocol { get }
}

public final class NetworkProvider: NetworkProviderProtocol {
    var agent: NetworkAgentProtocol
    init() { agent = NetworkAgent() }
}
