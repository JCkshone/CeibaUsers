//
//  AppHostingController.swift
//  ceiba-users
//
//  Created by Juan Camilo Navarro on 24/04/23.
//

import Foundation
import SwiftUI

class UsersHostingController<Content>: UIHostingController<AnyView> where Content : View {

  public init(rootView: Content) {
      super.init(rootView: AnyView(rootView.navigationBarHidden(true)))
  }

  @objc required dynamic init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}

