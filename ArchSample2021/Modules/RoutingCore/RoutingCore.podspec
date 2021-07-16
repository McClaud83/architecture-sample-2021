Pod::Spec.new do |spec|
  spec.name         = "RoutingCore"
  spec.version      = "0.0.1"
  spec.summary      = "RoutingCore"
  spec.description  = <<-DESC
    RoutingCore feature module
                   DESC
  spec.homepage     = "https://65apps.com"
  spec.license      = "BSD"
  spec.author       = { "Denis Timofeyev" => "dtimofeev@65apps.com" }
  spec.platform     = :ios, "11.0"
  spec.swift_version = "5.0"
  spec.source       = { :path => "." }
  spec.source_files  = "RoutingCore/**/*.{h,m,swift,xib,storyboard}"
  spec.frameworks = "Foundation", "UIKit"
  
  spec.dependency "Constants"

end
