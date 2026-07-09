// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "AnvyxDesignKit", targets: ["AnvyxDesignKit"]),
    ],
    targets: [
        .target(name: "AnvyxDesignKit"),
        .testTarget(name: "AnvyxDesignKitTests", dependencies: ["AnvyxDesignKit"]),
    ]
)
