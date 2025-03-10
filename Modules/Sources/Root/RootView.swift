//
//  RootView.swift
//  Modules
//
//  Created by 오상구 on 3/10/25.
//

import Service
import Network
import SwiftUI

public struct RootView: View {
  @State var viewModel: RootViewModel

  public init(
    viewModel: RootViewModel = .init()
  ) {
    _viewModel = .init(initialValue: viewModel)
  }

  public var body: some View {
    Text(viewModel.data)
      .task {
        await viewModel.loadExample()
      }
  }
}

#Preview {
  let viewModel = RootViewModel(
    exampleService: .init(
      repository: ExampleRepositoryMock(
        fetchDataHandler: {
          "RootView"
        }
      )
    )
  )
  RootView(viewModel: viewModel)
}
