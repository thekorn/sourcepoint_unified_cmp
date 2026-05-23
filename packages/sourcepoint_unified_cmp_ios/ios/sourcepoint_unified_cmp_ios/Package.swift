// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "sourcepoint_unified_cmp_ios",
  platforms: [
    .iOS("13.0"),
  ],
  products: [
    .library(
      name: "sourcepoint-unified-cmp-ios",
      targets: ["sourcepoint_unified_cmp_ios"]
    ),
  ],
  dependencies: [
    .package(
      url: "https://github.com/SourcePointUSA/ios-cmp-app",
      exact: "7.12.9"
    ),
  ],
  targets: [
    .target(
      name: "sourcepoint_unified_cmp_ios",
      dependencies: [
        .product(name: "ConsentViewController", package: "ios-cmp-app"),
      ]
    ),
  ]
)
