// swift-tools-version:5.9

import PackageDescription

// Matches cordova-plugin-firebasex-core/analytics so all Firebase comes from one
// SPM firebase-ios-sdk instead of double-linking via CocoaPods (which caused
// "redefinition of module 'Firebase'").
let firebaseSDKVersion: Version = "12.14.0"

let package = Package(
    name: "cordova-plugin-push",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "cordova-plugin-push",
            targets: ["cordova-plugin-push"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apache/cordova-ios.git", branch: "master"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", exact: firebaseSDKVersion)
    ],
    targets: [
        .target(
            name: "cordova-plugin-push",
            dependencies: [
                .product(name: "Cordova", package: "cordova-ios"),
                .product(name: "FirebaseCore", package: "firebase-ios-sdk"),
                .product(name: "FirebaseMessaging", package: "firebase-ios-sdk")
            ],
            path: "src/ios",
            publicHeadersPath: ".",
            linkerSettings: [
                .linkedFramework("PushKit"),
                .linkedFramework("UserNotifications")
            ]
        )
    ]
)
