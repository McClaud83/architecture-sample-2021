Pod::Spec.new do |spec|
    spec.name         = "ScenesCoordinator"
    spec.version      = "0.0.1"
    spec.summary      = "Scenes Coordinator"
    spec.description  = <<-DESC
      ScenesCoordinator feature module
                   DESC
    spec.homepage     = "https://65apps.com"
    spec.license      = "BSD"
    spec.author       = { "Denis Timofeyev" => "dtimofeev@65apps.com" }
    spec.platform     = :ios, "11.0"
    spec.swift_version = "5.0"
    spec.source       = { :path => "." }
    spec.source_files = "ScenesCoordinator/**/*.{h,m,swift,xib}"
    spec.frameworks = "Foundation", "UIKit"
    ## Другие сцены
    spec.dependency "SceneLoading"
    spec.dependency "SceneSignIn"
    spec.dependency "SceneContacts"    
end
