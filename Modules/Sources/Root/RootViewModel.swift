//
//  File.swift
//  Modules
//
//  Created by 오상구 on 3/10/25.
//

import Foundation
import Service

@Observable
@MainActor
public final class RootViewModel {
  var exampleService: ExampleService

  var data: String = ""

  public init(exampleService: ExampleService = .init()) {
    self.exampleService = exampleService
  }

  func loadExample() async {
    do {
      let result = try await exampleService.fetch()
      self.data = result
    } catch {
      print(error.localizedDescription)
    }
  }
}
