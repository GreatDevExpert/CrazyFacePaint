Pod::Spec.new do |s|
  s.name     = 'AdMobMediationAdapterAdColony'
  s.version  = '6.6.0'
  s.license      = { :type => 'Commercial', :text => 'Developer\'s use of the SDK is governed by the license in the applicable AdColony Terms of Service.' }
  s.summary  = 'AdMobMediationAdapterAdColony for analytics reporting.'
  s.homepage = 'http://www.apple.com'
  s.author   = { 'AdColony' => 'http://www.adcolony.com' }
  s.source   = { :git => 'https://github.com/williamlocke/AdMobMediationAdapterAdColony.git', :tag => '6.6.0' }
  s.description = 'AdMobMediationAdapterAdColony AdColony mediator.'
  s.platform = :ios
  s.source_files   = 'Classes/**/*.h'
  s.preserve_paths = 'Classes/**/*.a'
  s.library    = 'AdapterSDKAdColony'
  s.xcconfig   =  { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/AdMobMediationAdapterAdColony/Classes"' }
  
  
end