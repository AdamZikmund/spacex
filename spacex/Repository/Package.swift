// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Repository",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Repository",
            targets: ["Repository"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/AdamZikmund/Networking.git", .upToNextMajor(from: "1.0.0")),
        .package(name: "Store", path: "Store"),
        .package(name: "Model", path: "Model")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Repository",
            dependencies: ["Networking", "Store", "Model"],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "RepositoryTests",
            dependencies: ["Repository"]
        )
    ]
)
