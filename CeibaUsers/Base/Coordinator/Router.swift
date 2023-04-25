//
//  Router.swift
//  ceiba-users
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import SwiftUI

public protocol Router {
    associatedtype DefinitionView: View
    
    var transition: NavigationType { get }
    
    @ViewBuilder
    func view() -> DefinitionView
}
