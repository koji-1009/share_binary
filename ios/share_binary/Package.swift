// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "share_binary",
  platforms: [
    .iOS("12.0")
  ],
  products: [
    .library(name: "share-binary", targets: ["share_binary"])
  ],
  dependencies: [],
  targets: [
    .target(
      name: "share_binary",
      dependencies: [],
      resources: []
    )
  ]
)
