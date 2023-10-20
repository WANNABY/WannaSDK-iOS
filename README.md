# WANNA SDK

WANNA SDK enhances your iOS app with virtual try-on capabilities for shoes, watches and clothes. With this feature, your users will be able to see in real time how the selected product looks on them, just by pointing their smartphone camera at their feet, wrist or body. See the detailed documentation at the [WANNA website](https://docs.wanna.fashion/ios/getstarted).

<!-- TOC -->

- [License](#license)
- [Installation](#installation)
	- [Cocoapods](#cocoapods)
	- [Frameworks](#frameworks)
- [Sample](#sample)
- [Distribution](#distribution)
- [System requirements](#system-requirements)

<!-- /TOC -->

## License

WANNA SDK is intended for commercial use and is not open-source. You need a license key to work with the SDK.

To get a license key for WANNA SDK, kindly reach out to us at account@wanna.fashion using your business e-mail address. Please provide:

* a short description of your project
* a link to your company website
* any other information you consider relevant

### Terms of use

Working with WANNA SDK is subject to [Terms of use](https://wanna.fashion/terms-trial). Please review them before downloading the SDK and starting to use it.

## Installation

Add WANNA SDK to your project either as a cocoapods or by embedding the frameworks in your Xcode project.

### CocoaPods

Create a Podfile if you haven't yet:

```
$ cd <your-project-directory>
$ pod init
```

Add `pod WannaSDK` to your Podfile:

```
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '13.0'

inhibit_all_warnings!
use_frameworks!

target 'MyApp' do
  pod 'WannaSDK', '7.0.0'
end
```

Install the pod:

```
$ pod install
```

Open **Example.xcworkspace** file in Xcode.

**NOTE:** when you open Example.**xcodeproj** instead of Example.**xcworkspace** it will result in compiller error **No such module ‘WsneakersUISDK’**

### Frameworks

1. Add **WannaCoreSDK.xcframework** and **WsneakersUISDK.xcframework** to your project in Xcode.
2. Embed these frameworks in the main bundle of your project.

## Sample

Our distribution includes a simple code sample in Swift: see **ios/Swift** folder in the distribution. Use it to test our SDK capabilities or as a starting point to develop your own app.

Before building and running the sample:

1. Enter your license key in **WannaSDKDefaults.swift**:
```
static let clientConfig = "" // <-- Change license here
```
2. Assign a development team to the sample Xcode project, to ensure it's signed correctly. Go to the **Signing & Capabilities** tab in Xcode and choose the appropriate value in the **Team** dropdown list.

## Distribution

* **ios** folder with code samples in Swift and Objective-C for the basic virtual try-on scenario.
* **WannaSDK** folder with the library files required if you are using WANNA SDK. Redistribute these with your application.
* **readme** folder with this file and other product documentation.
 
## System requirements

* iOS version: 14.0 and later
* Supported devices: iPhone SE/6s and newer
* Memory requirements: 
    * Footprint: 
        * zipped size: 3.8 MB
        * unzipped size: 9.4 MB
        * cache for neural networks and auxiliary files: 25 MB
        * the size of cache for 3D models can be set up via API<br />
		**Note:** 3D model size varies depending on its quality. The model is downloaded right after session starts.
    * RAM: up to 600 MB, depending on the size and quality of a 3D model
______________________________
Zipped size means the size which will be added to your IPA file, i.e. to the downloadable size of your application, when you integrate the WANNA SDK.
Unzipped size means the size of the library as part of the installed application.
   
