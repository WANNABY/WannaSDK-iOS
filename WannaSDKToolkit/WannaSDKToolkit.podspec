Pod::Spec.new do |s|
    s.name                  = 'WannaSDKToolkit'
    s.version               = '0.0.1'

    s.summary               = 'Wanna SDK Toolkit'
    s.description           = <<-DESCRIPTION
    WannaSDKToolkit toolkit for iOS development.
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
    s.source_files          = 'Sources/**/*.{h,m,swift}'
    s.platform              = 'ios', 'macos'

    s.ios.deployment_target = '12.0'
end