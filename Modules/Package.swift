// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Modules",
  platforms: [.iOS(.v18)],
  products: [
    .library(name: "Core", targets: ["Core"]),
    .library(name: "Network", targets: ["Network"]),
    .library(name: "Service", targets: ["Service"]),
    .library(name: "Root", targets: ["Root"]),
  ],
  targets: [
    .target(name: "Core"),
    .target(name: "Network", dependencies: ["Core"]),
    .target(name: "Service", dependencies: ["Core", "Network"]),
    .target(name: "Root", dependencies: ["Core", "Service"]),
  ]
)
