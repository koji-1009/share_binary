## 1.6.0

* Fix Swift Package Manager support: raise minimum Flutter to `>=3.44.0` and Dart SDK to `>=3.12.0`, matching the `FlutterFramework` Swift package that the SPM manifest depends on
* Adopt the iOS UIScene lifecycle (`UISceneDelegate`): resolve the presenting view controller via `FlutterPluginRegistrar.viewController` instead of scanning `UIApplication.shared.connectedScenes`
* Migrate Android to the Android Gradle Plugin 9 / built-in Kotlin toolchain (AGP 9.0.1, Kotlin 2.3.20)
* Update Android `compileSdk` to 36 and raise `minSdk` to 24

## 1.5.0

* Change Android `shareBinary` from `ACTION_VIEW` to `ACTION_SEND` for broader app sharing support
* Use `UIWindowScene` API for root view controller on iOS (minimum iOS 16.0)
* Fix `UIActivityViewController` anchor view leak on iPad
* Update Kotlin to 2.2.20, AGP to 8.11.1, compileSdk to 35
* Update Dart SDK to `>=3.9.0`, Flutter to `>=3.35.0`

## 1.4.0

* Update meta package to `^2.0.0`
* Update web package to `^1.0.0`
* Update flutter sdk constraints to `>=3.22.0`
* Update android gradle file
* Update example

## 1.3.1

* Format swift code
* Update dependencies

## 1.3.0

* Support Swift Package Manager
* Minimum iOS version is >= 12.0

## 1.2.0

* Remove Privacy Manifest

## 1.1.2

* Fix UIActivityViewController popover presentation on iPad

## 1.1.1

* Require web package `^0.5.1`

## 1.1.0

* Add Privacy Manifest

## 1.0.1

* Code cleanup

## 1.0.0

* Support web platform

## 0.2.4

* Improved performance of iOS file generation process

## 0.2.3

* Delete previous cache file before saving new one

## 0.2.2

* Fix podspec

## 0.2.1

* Fix share behavior on iOS

## 0.2.0

* Cleanup swift code
* Add doc file to example

## 0.1.0

* Initial release
* Add `shareBinary` method
* Add `shareUri` method
