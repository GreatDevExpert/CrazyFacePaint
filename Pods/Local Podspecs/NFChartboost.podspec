Pod::Spec.new do |s|
  s.name         = "NFChartboost"

  s.version      = "0.2.2"

  s.summary      = "NFChartboost."

  s.homepage     = "https://github.com/ninjafishstudios/NFChartboost"

	s.license      = { :type => 'FreeBSD', :file => 'LICENSE.txt' }

  s.author       = { "williamlocke" => "williamlocke@me.com" }

  s.source       = { :git => "https://github.com/ninjafishstudios/NFChartboost.git", :tag => s.version.to_s }

  s.platform     = :ios, '4.3'
  
  s.source_files =  'Classes/NFChartboost/*.[h,m]'

  s.resources = 'Resources/NFChartboost.bundle'
  
  s.frameworks = 'QuartzCore'
  
  s.requires_arc = true
  
	s.dependency 'ChartboostSDK', '= 4.5'
  
end
