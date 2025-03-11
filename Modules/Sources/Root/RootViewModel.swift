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

enum RootAction {
  case loadExample
}

@Observable
@MainActor
public final class RootViewModel {
  var state: RootState = .init()

  var exampleService: ExampleService


  public init(exampleService: ExampleService) {
    self.exampleService = exampleService
  }

  func send(_ action: RootAction) {
    switch action {
      case .loadExample:
        Task {
          do {
            let result = try await exampleService.fetch()
            state.data = result
          } catch {
            state.data = error.localizedDescription
          }
        }
    }
  }
}

