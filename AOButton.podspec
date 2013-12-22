Pod::Spec.new do |s|
  s.name         = "AOButton"
  s.version      = "1.0"
  s.summary      = "Custom scaling button"
  s.description  = "Custom button that scales whet is tapped"
  s.homepage     = "https://github.com/alekoleg/AOButton.git"
  s.license      = 'MIT'
  s.author       = { "Oleg Alekseenko" => "alekoleg@gmail.com" }
  s.source       = { :git => "https://github.com/alekoleg/AOButton.git", :tag => s.version.to_s}
  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.requires_arc = true

  s.source_files = 'Classes/*.{h,m}'


  s.public_header_files = 'Classes/*.h'
  s.frameworks = 'Foundation', 'UIKit', 'QuartzCore', 'CoreGraphics'
  
end
