Pod::Spec.new do |spec|
  spec.name         = "SceneLoading"
  spec.version      = "0.0.1"
  spec.summary      = "SceneLoading"
  spec.description  = <<-DESC
  SceneLoading feature module
                   DESC
  spec.homepage     = "https://65apps.com"
  spec.license      = "BSD"
  spec.author       = { "Denis Timofeyev" => "dtimofeev@65apps.com" }
  spec.platform     = :ios, "11.0"
  spec.swift_version = "5.0"
  spec.source       = { :path => "." }
  spec.source_files = "SceneLoading/**/*.{h,m,swift,xib}"
  spec.frameworks = "Foundation", "UIKit"
  ## Добавляем ресурсы в бандл
  spec.resource_bundles = {
    'SceneLoadingResources' => ['SceneLoading/Resources/**/*.xib']
  }
  spec.exclude_files = "SceneLoading/Exclude"
  ## Прочие зависимости
  spec.dependency "RxSwift"
  spec.dependency "UseCases"
  spec.dependency "RoutingCore"
  spec.dependency "RxViewController"
  spec.dependency "Extensions"
end
