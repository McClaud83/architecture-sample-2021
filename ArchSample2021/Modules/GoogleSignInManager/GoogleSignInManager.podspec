Pod::Spec.new do |spec|
    spec.name         = "GoogleSignInManager"
    spec.version      = "0.0.1"
    spec.summary      = "Google SignIn Manager"
    spec.description  = <<-DESC
      GoogleSignInManager feature module
                   DESC
    spec.homepage     = "https://65apps.com"
    spec.license      = "BSD"
    spec.author       = { "Denis Timofeyev" => "dtimofeev@65apps.com" }
    spec.platform     = :ios, "11.0"
    spec.swift_version = "5.0"
    spec.source       = { :path => "." }
    spec.source_files = "GoogleSignInManager/**/*.{h,m,swift}"
    spec.frameworks = "Foundation", "UIKit", "LocalAuthentication", "SafariServices", "AuthenticationServices", "SystemConfiguration"
    spec.dependency "RxSwift"
    spec.dependency "Models"
    spec.dependency "Constants"
    spec.dependency "AppAuth"
    spec.dependency "GTMAppAuth"
    spec.dependency "GTMSessionFetcher/Core"
    ## прикручиваем static либу "GoogleSignIn"
    spec.vendored_frameworks = "Frameworks/GoogleSignIn.framework", "Frameworks/GoogleSignInDependencies.framework"
    spec.resources = "Frameworks/GoogleSignIn.bundle"
    spec.pod_target_xcconfig = {
      "OTHER_LDFLAGS" => '$(inherited) -ObjC -framework "GoogleSignIn"',
      "CLANG_MODULES_AUTOLINK" => "YES"
    }
end
