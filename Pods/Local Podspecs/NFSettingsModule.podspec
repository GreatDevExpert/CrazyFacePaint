Pod::Spec.new do |s|
  s.name         = "NFSettingsModule"

  s.version      = "0.1.0"

  s.summary      = "NFSettingsModule"

  s.homepage     = "https://github.com/ninjafishstudios/NFSettingsModule"

	s.license      = { :type => 'FreeBSD', :file => 'LICENSE.txt' }

  s.author       = { "williamlocke" => "williamlocke@me.com" }

  s.source       = { :git => "https://github.com/ninjafishstudios/NFSettingsModule.git", :tag => s.version.to_s }

  s.platform     = :ios, '4.3'
  
  s.source_files =  'Classes/NFSettingsModule/*.[h,m]'
  
  s.frameworks = 'QuartzCore'
  s.requires_arc = true
  
  
end
