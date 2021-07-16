Pod::Spec.new do |spec|
    spec.name         = "Networking"
    spec.version      = "0.0.1"
    spec.summary      = "Networking"
    spec.description  = <<-DESC
      Networking feature module
                   DESC
    spec.homepage     = "https://65apps.com"
    spec.license      = "BSD"
    spec.author       = { "Denis Timofeyev" => "dtimofeev@65apps.com" }
    spec.platform     = :ios, "11.0"
    spec.swift_version = "5.0"
    spec.source       = { :path => "." }
    spec.source_files = "Networking/**/*.{h,m,swift,xib}"
    spec.frameworks = "Foundation", "UIKit"
    ##
    spec.dependency 'RxSwift'
    spec.dependency 'Moya/RxSwift', '14.0.0'
    spec.dependency 'Constants'
    spec.dependency 'Models'
    spec.dependency 'RxSwift'
end
