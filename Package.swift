// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ALDevKit",
    platforms: [ .iOS(.v13), .tvOS(.v13), .watchOS(.v6) ],
    products: [ .library(name: "ALDevKit", targets: ["ALDevKit"]) ],
    dependencies: [
        .package(
            url: "https://github.com/SnapKit/SnapKit",
            .upToNextMajor(from: "5.0.0")),
        .package(
            url: "https://github.com/ivanvorobei/SparrowKit",
            .upToNextMajor(from: "3.0.0"))
    ],
    targets: [ .target(name: "ALDevKit", dependencies: ["SnapKit", "SparrowKit"])]
)
