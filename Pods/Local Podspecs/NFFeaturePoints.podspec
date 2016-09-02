Pod::Spec.new do |s|
  s.name         = "NFFeaturePoints"

  s.version      = "1.0.0"

  s.summary      = "Feature Points."

  s.homepage     = "https://github.com/ninjafishstudios/NFFeaturePoints"

	s.license      = { :type => 'FreeBSD', :file => 'LICENSE.txt' }

  s.author       = { "williamlocke" => "williamlocke@me.com" }

  s.source       = { :git => "https://github.com/ninjafishstudios/NFFeaturePoints.git", :tag => s.version.to_s }

  s.platform     = :ios, '4.3'
  
  s.source_files =  'Classes/NFFeaturePoints/*.[h,m]'

  s.resources = 'Resources/NFFeaturePoints.bundle'
  
  s.requires_arc = true
    
#	s.dependency 'FeaturePoints'
  
end
