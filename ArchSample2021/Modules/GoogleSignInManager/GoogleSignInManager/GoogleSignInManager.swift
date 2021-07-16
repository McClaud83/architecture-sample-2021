import Foundation
import RxSwift
import UIKit.UIViewController
import Models

public protocol GoogleSignInManager {
    func signIn(on viewController: UIViewController) -> Single<GoogleUserInfo?>
    func refreshToken(on viewController: UIViewController) -> Single<String?>
    func signOut() -> Single<Void?>
}

public class GoogleSignInManagerDummy: GoogleSignInManager {
    public init() {
    }
    
    public func signIn(on viewController: UIViewController) -> Single<GoogleUserInfo?> {
        return Single.just(nil)
    }
    
    public func refreshToken(on viewController: UIViewController) -> Single<String?> {
        return Single.just(nil)
    }
    
    public func signOut() -> Single<Void?> {
        return Single.just(nil)
    }
    
    
}
