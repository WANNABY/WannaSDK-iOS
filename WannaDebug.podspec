Pod::Spec.new do |s|
  s.name                    = 'WannaDebug'
  s.version                 = '8.0.0'
  s.author                  = 'help@wanna.fashion'
  s.homepage                = "https://wanna.fashion"
  s.readme                  = "https://github.com/WANNABY/WannaSDK-iOS/blob/master/README.md"

  s.platform                = 'ios', 'macos'
  s.ios.deployment_target   = '12.0'
  s.swift_version           = '5.9'

  s.summary                 = 'Mobile Virtual Try-On SDK'

  s.license                 = {
    :type => 'Commercial',
    :text => <<-LICENSE
    Working with WANNA SDK is subject to Terms of use(https://wanna.fashion/terms-trial). Please review them before downloading the SDK and starting to use it.
    LICENSE
  }

  s.description             = <<-DESC
  WANNA SDK empowers iOS applications with the Augmented Reality (AR) Try-On
  capabilities for shoes and watches. Once integrated, the AR Try-On feature
  allows app users to try sneakers or watches in real-time with their
  smartphones by pointing a mobile camera at their feet or wrist.
  DESC

  s.source                  = {
    :git => 'https://github.com/WANNABY/WannaSDK-iOS.git',
    :branch => 'master'
  }

  s.source_files            = 'Debug/Sources/**/*.{swift}'
  s.dependency              'WannaSDK'
end
