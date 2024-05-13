Pod::Spec.new do |s|
    s.name                  = 'WannaTryOn'
    s.version               = '0.0.1'

    s.summary               = 'Wanna SDK Try-On UIKit Component'
    s.description           = <<-DESCRIPTION
    WannaTryOn provides UIKit component for easy try-on integration.
    DESCRIPTION
    s.homepage              = "https://wanna.fashion"
    s.author                = "help@wanna.fashion"
    s.license = { 
        :type => 'Commercial', 
        :text => <<-LICENSE
        Working with WANNA SDK is subject to Terms of use(https://wanna.fashion/terms-trial). Please review them before downloading the SDK and starting to use it.
        LICENSE
    }

    s.source                = { :git => '../' }
    s.source_files          = 'Sources/**.{h,m,swift}'
    s.platform              = 'ios', 'macos'

    s.ios.deployment_target = '12.0'
    
    s.dependency 'WannaSDK'
    s.dependency 'WannaSDKToolkit'
end