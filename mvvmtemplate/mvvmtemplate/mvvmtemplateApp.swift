//
//  mvvmtemplateApp.swift
//  mvvmtemplate
//
//  Created by 오상구 on 3/10/25.
//

import Root
import SwiftUI

@main
struct mvvmtemplateApp: App {
  @Environment(\.exampleService) var exampleService

  var body: some Scene {
    WindowGroup {
      RootView(viewModel: .init(exampleService: exampleService))
    }
  }
}
