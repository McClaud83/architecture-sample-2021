Pod::Spec.new do |spec|
    spec.name         = "DataManagers"
    spec.version      = "0.0.1"
    spec.summary      = "Data Managers"
    spec.description  = <<-DESC
      DataManagers feature module
                   DESC
    spec.homepage     = "https://65apps.com"
    spec.license      = "BSD"
    spec.author       = { "Denis Timofeyev" => "dtimofeev@65apps.com" }
    spec.platform     = :ios, "11.0"
    spec.swift_version = "5.0"
    spec.source       = { :path => "." }
    spec.source_files = "DataManagers/**/*.{h,m,swift,xib}"
    spec.frameworks = "Foundation", "UIKit"
    spec.dependency "RxSwift"
    spec.dependency "Models"
    spec.dependency "Constants"
    spec.dependency "GoogleSignInManager"
    spec.dependency "Networking"
end
