// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ALDevKit",
    platforms: [ .iOS(.v13), .tvOS(.v13), .watchOS(.v6) ],
    products: [ .library(name: "ALDevKit", targets: ["ALDevKit"]) ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit", .branch("develop")),
        .package(url: "https://github.com/ivanvorobei/SparrowKit", .branch("main"))
    ],
    targets: [ .target(name: "ALDevKit", dependencies: ["SnapKit", "SparrowKit"])]
)
