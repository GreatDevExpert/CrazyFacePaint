Pod::Spec.new do |s|
  s.name         = "Fiksu-iOS-SDK"
  s.version      = "4.3.1"
  s.summary = 'This is the unofficial CocoaPod for the Fiksu iOS SDK'
  s.description = 'The Fiksu SDK provides access to Fiksu marketing programs which give you access to 99% of the worldwide mobile media and can help you generate large volumes of high quality users who monetize and drive your business model.'
  s.homepage     = "http://www.fiksu.com/"
  s.license      = { :file => 'FiksuSDK.embeddedframework/Resources/LICENSE.txt', :type => 'Copyright' }
  s.source = { :git => 'git@github.com:sanjitsaluja/FiksuSDK.git', :tag => '4.3.1' }
  s.author             = { "Fiksu, Inc." => "support@fiksu.com" }
  s.social_media_url = "https://twitter.com/Fiksu"

  s.platform     = :ios, '5.1'

  s.public_header_files = "FiksuSDK.embeddedframework/FiksuSDK.framework/**/*.h"
  s.resources  = "FiksuSDK.embeddedframework/FiksuSDK.framework/**/*.{png,nib}"
  s.preserve_paths = 'FiksuSDK.embeddedframework/FiksuSDK.framework'

  s.vendored_frameworks = 'FiksuSDK.embeddedframework/FiksuSDK.framework'
  s.framework = 'MessageUI', 'SystemConfiguration'
  s.weak_frameworks = 'AdSupport', 'StoreKit'

  s.xcconfig     = { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/Fiksu-iOS-SDK/**"'}
  s.requires_arc = true
end
