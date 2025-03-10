//
//  File.swift
//  Modules
//
//  Created by 오상구 on 3/10/25.
//

import Foundation

public protocol ExampleRepository: Sendable {
  func fetchData() async -> String
}

public struct ExampleRepositoryLive: ExampleRepository {
  public init() {}

  public func fetchData() async -> String {
    "Hello, World!"
  }
}

public struct ExampleRepositoryMock: ExampleRepository {
  private let fetchDataHandler: @Sendable () async -> String

  public init(
    fetchDataHandler: @escaping @Sendable () async -> String = { "Mock Data" }
  ) {
    self.fetchDataHandler = fetchDataHandler
  }

  public func fetchData() async -> String {
    await fetchDataHandler()
  }
}
