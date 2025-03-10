//
//  Untitled.swift
//  Modules
//
//  Created by 오상구 on 3/10/25.
//
import Network

public struct ExampleService: Sendable {
  let repository: ExampleRepository

  public init(
    repository: ExampleRepository = ExampleRepositoryLive()
  ) {
    self.repository = repository
  }


  public func fetch() async throws -> String {
    await repository.fetchData()
  }
}
