// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoginModule",
    defaultLocalization: "en",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "LoginModule", targets: ["LoginModule"]),
        .library(name: "LoginModuleFirebase", targets: ["LoginModuleFirebase"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.0.0")
    ],
    targets: [
        .target(
            name: "LoginModule",
            dependencies: [],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "LoginModuleFirebase",
            dependencies: [
                "LoginModule",
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk")
            ]
        ),
        .testTarget(
            name: "LoginModuleTests",
            dependencies: ["LoginModule"]),
    ]
)
