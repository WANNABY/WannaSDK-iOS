# WANNA SDK

WANNA SDK enhances your iOS app with virtual try-on capabilities for shoes and watches. With this feature, your users will be able to see in real time how the selected product looks on them, just by pointing their smartphone camera at their feet or wrist. See the detailed documentation at the [WANNA website](https://docs.wanna.fashion/ios/getstarted).

<!-- TOC -->

- [Installation](#installation)
	- [Cocoapods](#cocoapods)

<!-- /TOC -->

## Installation

### CocoaPods

Create a Podfile if you haven't yet:

```
$ cd <your-project-directory>
$ pod init
```

Add `pod WannaSDK` to your Podfile:

```
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '15.0'

inhibit_all_warnings!
use_frameworks!

target 'MyApp' do
  pod 'WannaSDK'
end
```

Install the pod:

```
$ pod install
```

Open **Example.xcworkspace** file in Xcode.

**NOTE:** when you open Example.**xcodeproj** instead of Example.**xcworkspace** it will result in compiller error **No such module ‘WsneakersUISDK’**

   
### Swift Package Manager

#### Installing from Xcode

Add a package by selecting `File` → `Add Packages…` in Xcode’s menu bar.

Search for the WannaSDK using the repo's URL:
```console
https://github.com/WANNABY/WannaSDK-iOS.git
```

Next, set the **Dependency Rule** to be `Up to Next Major Version`.

Then, select **Add Package**.

#### Alternatively, add WannaSDK to a `Package.swift` manifest

To integrate via a `Package.swift` manifest instead of Xcode, you can add
WannaSDK to the dependencies array of your package:

```swift
dependencies: [
  .package(
    name: "WannaSDK",
    url: "https://github.com/WANNABY/WannaSDK-iOS.git",
    .upToNextMajor(from: "7.1.1")
  ),

  // Any other dependencies you have...
],
```
