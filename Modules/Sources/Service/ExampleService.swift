//
//  Untitled.swift
//  Modules
//
//  Created by 오상구 on 3/10/25.
//
import Network
import SwiftUI

public struct ExampleService: Sendable {
  let repository: ExampleRepository
  
  public init(
    repository: ExampleRepository = ExampleRepositoryLive()
  ) {
    self.repository = repository
  }
  
  
  public func fetch() async throws -> String {
    try await repository.fetchData()
  }
}

private struct ExampleServiceKey: EnvironmentKey {
  static let defaultValue: ExampleService = ExampleService()
}

// MARK: Environment
public extension EnvironmentValues {
  var exampleService: ExampleService {
    get { self[ExampleServiceKey.self] }
    set { self[ExampleServiceKey.self] = newValue }
  }
}
