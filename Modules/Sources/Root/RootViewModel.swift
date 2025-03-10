//
//  File.swift
//  Modules
//
//  Created by 오상구 on 3/10/25.
//

import Foundation
import Service

struct RootState {
  var data: String = ""
}

@Observable
@MainActor
public final class RootViewModel {
  var state: RootState = .init()

  var exampleService: ExampleService


  public init(exampleService: ExampleService = .init()) {
    self.exampleService = exampleService
  }

  func loadExample() async {
    do {
      let result = try await exampleService.fetch()
      state.data = result
    } catch {
      print(error.localizedDescription)
    }
  }
}
