Pod::Spec.new do |spec|
  spec.name         = "Extensions"
  spec.version      = "0.0.1"
  spec.summary      = "Extensions"
  spec.description  = <<-DESC
      Extensions feature module
                   DESC
  spec.homepage     = "https://65apps.com"
  spec.license      = "BSD"
  spec.author       = { "Denis Timofeyev" => "dtimofeev@65apps.com" }
  spec.platform     = :ios, "11.0"
  spec.swift_version = "5.0"
  spec.source       = { :path => "." }
  spec.source_files  = "Extensions/**/*.{h,m,swift,xib}"
  spec.frameworks = "Foundation", "UIKit"
  spec.dependency "RxSwift"
  spec.dependency "RxCocoa"
  spec.dependency "Common"
end
