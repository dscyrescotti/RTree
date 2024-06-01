// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RTree",
    products: [
        .library(
            name: "RTree",
            targets: ["RTree"]
        ),
    ],
    targets: [
        .target(name: "RTree"),
        .testTarget(
            name: "RTreeTests",
            dependencies: ["RTree"]
        ),
    ]
)
