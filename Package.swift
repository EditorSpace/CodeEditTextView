// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CodeEditTextView",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "CodeEditTextView",
            targets: ["CodeEditTextView"]
        ),
    ],
    dependencies: [
        .package(
            path: "../STTextView"
        ),
        .package(
            url: "https://github.com/CodeEditApp/CodeEditLanguages.git",
            exact: "0.1.11"
        ),
        .package(
            url: "https://github.com/lukepistrol/SwiftLintPlugin",
            from: "0.2.2"
        ),
        .package(
            url: "https://github.com/ChimeHQ/TextFormation",
            from: "0.6.7"
        ),
        .package(
            url: "https://github.com/ChimeHQ/ProcessEnv",
            from: "0.3.1"
        ),
        .package(path: "../LanguageClient"),
    ],
    targets: [
        .target(
            name: "CodeEditTextView",
            dependencies: [
                "STTextView",
                "CodeEditLanguages",
                "TextFormation",
                "ProcessEnv",
                "LanguageClient"
            ]
//            plugins: [
//                .plugin(name: "SwiftLint", package: "SwiftLintPlugin")
//            ]
        ),
        .testTarget(
            name: "CodeEditTextViewTests",
            dependencies: [
                "CodeEditTextView",
                "CodeEditLanguages",
            ]
        ),
    ]
)
