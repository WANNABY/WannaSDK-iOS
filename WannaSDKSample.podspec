Pod::Spec.new do |s|
  s.name                    = 'WannaSample'
  s.version                 = '0.0.1'
  s.author                  = 'help@wanna.fashion'
  s.homepage                = "https://wanna.fashion"
  s.readme                  = "https://github.com/WANNABY/WannaSDK-iOS/blob/master/README.md"
  
  s.platform                = 'ios', 'macos'
  s.ios.deployment_target   = '12.0'

  s.summary                 = 'Mobile Virtual Try-On SDK'

  s.description             = <<-DESC
  WANNA SDK empowers iOS applications with the Augmented Reality (AR) Try-On
  capabilities for shoes and watches. Once integrated, the AR Try-On feature
  allows app users to try sneakers or watches in real-time with their
  smartphones by pointing a mobile camera at their feet or wrist.
  DESC

  s.license                 = { 
    :type => 'Commercial', 
    :text => <<-LICENSE
    Working with WANNA SDK is subject to Terms of use(https://wanna.fashion/terms-trial). Please review them before downloading the SDK and starting to use it.
    LICENSE
  }

  s.source           = { 
    :git => 'https://github.com/WANNABY/WannaSDK-iOS.git',
    :branch => 'update-sample-app-2'
  }

  # s.ios.preserve_paths = 'WsneakersUISDK.xcframework', 'WannaCoreSDK.xcframework'
  # s.ios.vendored_frameworks = 'WsneakersUISDK.xcframework', 'WannaCoreSDK.xcframework'

  # s.resource_bundles = {
  #   "WannaCoreSDK" => ["WannaCoreSDK.xcframework/PrivacyInfo.xcprivacy"],
  #   "WsneakersUISDK" => ["WsneakersUISDK.xcframework/PrivacyInfo.xcprivacy"]
  # }

  s.subspec 'TryOn' do |ss|
    ss.source_files     = 'WannaTryOn/Sources/**.{h,m,swift}'
    ss.dependency       'WannaSDK'
    ss.dependency       'WannaSDKSample/Toolkit'
  end

  s.subspec 'Toolkit' do |ss|
    ss.source_files     = 'WannaToolkit/Sources/**.{h,m,swift}'
  end
end


