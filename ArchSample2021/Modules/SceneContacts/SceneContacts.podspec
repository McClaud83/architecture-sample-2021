Pod::Spec.new do |spec|
    spec.name         = "SceneContacts"
    spec.version      = "0.0.1"
    spec.summary      = "Contacts scene"
    spec.description  = <<-DESC
      SceneContacts feature module
                   DESC
    spec.homepage     = "https://65apps.com"
    spec.license      = "BSD"
    spec.author       = { "Denis Timofeyev" => "dtimofeev@65apps.com" }
    spec.platform     = :ios, "11.0"
    spec.swift_version = "5.0"
    spec.source       = { :path => "." }
    spec.source_files = "SceneContacts/**/*.{h,m,swift,xib}"
    spec.frameworks = "Foundation", "UIKit"
    ## Добавляем ресурсы в бандл
    spec.resource_bundles = {
      'SceneContactsResources' => ['SceneContacts/Resources/**/*.xib']
    }
    spec.exclude_files = "SceneContacts/Exclude"
    ## Прочие зависимости
    spec.dependency "RxSwift"
    spec.dependency "RxViewController"
    spec.dependency "RxSwiftExtensions"
    spec.dependency "RxDataSources"
    spec.dependency "UseCases"
    spec.dependency "RoutingCore"
    spec.dependency "Extensions"
    spec.dependency "Common"
end
