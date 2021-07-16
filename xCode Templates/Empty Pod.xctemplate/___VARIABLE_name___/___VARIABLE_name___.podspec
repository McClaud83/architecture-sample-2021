Pod::Spec.new do |spec|
    spec.name         = "___VARIABLE_name___"
    spec.version      = "0.0.1"
    spec.summary      = "___VARIABLE_description___"
    spec.description  = <<-DESC
      ___VARIABLE_name___ feature module
                   DESC
    spec.homepage     = "https://65apps.com"
    spec.license      = "BSD"
    spec.author       = { "___VARIABLE_author_name___" => "___VARIABLE_author_email___" }
    spec.platform     = :ios, "11.0"
    spec.swift_version = "5.0"
    spec.source       = { :path => "." }
    spec.source_files = "___VARIABLE_name___/**/*.{h,m,swift,xib}"
    spec.frameworks = "Foundation", "UIKit"
end
