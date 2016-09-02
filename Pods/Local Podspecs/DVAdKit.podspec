Pod::Spec.new do |s|
  s.name         = "DVAdKit"

  s.version      = "2.13.0"

  s.summary      = "DVAdKit development libraries."

  s.homepage     = "https://github.com/ninjafishstudios/DVAdKit"

	s.license      = { :type => 'Commercial', :file => 'LICENSE.txt' }

  s.author       = { "williamlocke" => "williamlocke@me.com" }

  s.source       = { :git => "https://github.com/ninjafishstudios/DVAdKit.git", :tag => s.version.to_s }

  s.platform     = :ios, '5.0'
  
  s.resources = '{DVAdKit.podspec,Resources/DVAdKit.bundle}'


  s.subspec 'Models' do |ccs|
    ccs.source_files =  'Classes/DVAdKit/Models/**/*.[h,m]'
    ccs.resources = 'Resources/DVAdKit.bundle'
  end
  s.subspec 'UserInterface' do |ccs|
    ccs.source_files =  'Classes/DVAdKit/UserInterface/**/*.[h,m]'
  end
  
  s.subspec 'Interactives' do |ccs|
    ccs.source_files =  'Classes/DVAdKit/Interactives/**/*.[h,m]'
  end
  
  s.subspec 'MoreGames' do |ccs|
    ccs.source_files =  'Classes/DVAdKit/MoreGames/**/*.[h,m]'
  end
  
  s.subspec 'WebAPI' do |ccs|
    ccs.source_files =  'Classes/DVAdKit/WebAPI/**/*.[h,m]'
  end
  
  s.subspec 'DVStoreKit' do |ccs|
    ccs.source_files =  'Classes/DVStoreKit/**/*.[h,m]'
  end

  
  s.subspec 'SDK' do |ccs|
    ccs.source_files =  'Classes/DVAdKit/SDK/**/*.[h,m]'
  end
  
  
  s.subspec 'DVNetworking' do |ccs|
    ccs.source_files =  'Classes/DVLibrary/DVNetworking/**/*.[h,m]'
  end
  s.subspec 'DVDataStore' do |ccs|
    ccs.source_files =  'Classes/DVLibrary/DVDataStore/**/*.[h,m]'
  end
  s.subspec 'DVDate' do |ccs|
    ccs.source_files =  'Classes/DVLibrary/DVDate/**/*.[h,m]'
  end


  

	s.dependency 'MD5Digest', '=0.1.0'
	s.dependency 'OpenUDID'
  s.dependency 'AFNetworking', '= 1.3.3'
  s.dependency 'SBJson', '=2.2.3'
  s.dependency 'IAPValidation'


	
  # TODO: Use conditional compilation rather than dependency. 
#  s.source_files =  'Classes/DVAdKit/*.[h,m]'
  
  s.frameworks = 'AdSupport', 'QuartzCore', 'StoreKit'
  

  s.requires_arc = true


end
