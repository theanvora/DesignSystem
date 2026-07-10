// swift-tools-version: 6.2
import PackageDescription

let concurrencyBaseline: [SwiftSetting] = [
    .swiftLanguageMode(.v6),
    .defaultIsolation(nil),
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
    .enableUpcomingFeature("InferIsolatedConformances"),
]

let package = Package(
    name: "DesignSystem",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "AnvyxDesignKit", targets: ["AnvyxDesignKit"]),
    ],
    targets: [
        .target(name: "AnvyxDesignKit", swiftSettings: concurrencyBaseline),
        .testTarget(name: "AnvyxDesignKitTests", dependencies: ["AnvyxDesignKit"], swiftSettings: concurrencyBaseline),
    ]
)
