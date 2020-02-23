// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "MonoRepo",
    products: [
        .executable(name: "mr", targets: ["Interface"]),
        .library(name: "MonoRepo", targets: ["MonoRepo"])
    ],
    dependencies: [],
    targets: [
        .target(name: "Interface", dependencies: ["MonoRepo"]),
        .target(name: "MonoRepo", dependencies: [])
    ]
)
