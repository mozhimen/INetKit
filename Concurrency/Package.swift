// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "INetKit.Concurrency",
    platforms: [
        .macOS(.v12),.iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "INetKit.Concurrency",
            targets: ["INetKit.Concurrency"]),
    ],
    dependencies: [
//        .package(name: "SUtilKit", path:"../SUtilKit"),	
        .package(name: "ISwiftKit.Service", path:"../../ISwiftKit/Service"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "INetKit.Concurrency",dependencies: ["ISwiftKit.Service"]),

    ]
)
