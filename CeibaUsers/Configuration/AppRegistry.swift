//
//  AppRegistry.swift
//  ceiba-users
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import Foundation

class AppplicationRegistry: NSObject, AppLifecycleProtocol {
    override init() {
        super.init()
        AppDependencies.bindComponents()
    }
}

struct AppRegistry {
    var registry: [AppLifecycleProtocol]
    
    init() {
        self.registry = [
            AppplicationRegistry()
        ]
    }
    
    func getRegistry() -> [AppLifecycleProtocol] { registry }
}

