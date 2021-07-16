import UIKit.UIViewController
import RxSwift
import Models
import Constants
import GoogleSignIn

public final class GoogleSignInManagerImpl: GoogleSignInManager {
    let signInResultSubject = PublishSubject<GoogleUserInfo?>()
    let refreshResultSubject = BehaviorSubject<GoogleUserInfo?>(value: nil)
    let signOutResultSubject = PublishSubject<Void?>()
    let googleSignInProxyDelegate: GoogleSignInProxy
    
    public init() {
        googleSignInProxyDelegate = GoogleSignInProxy()
        googleSignInProxyDelegate.delegate = self
        
        let googleInstance = GIDSignIn.sharedInstance()!
        googleInstance.clientID = Environment.googleApiKey
        googleInstance.delegate = self.googleSignInProxyDelegate
        googleInstance.scopes.append(Constants.GoogleContactsScope)
    }
    
    public func signIn(on viewController: UIViewController) -> Single<GoogleUserInfo?> {
        let googleInstance = GIDSignIn.sharedInstance()!
        googleInstance.presentingViewController = viewController
        googleInstance.signIn()
        return self.signInResultSubject
            .take(1)
            .asSingle()
            .debug("signIn")
    }

    public func refreshToken(on viewController: UIViewController) -> Single<String?> {
        let googleInstance = GIDSignIn.sharedInstance()!
        googleInstance.presentingViewController = viewController
        googleInstance.restorePreviousSignIn()
        return self.refreshResultSubject
            .take(1)
            .map { $0?.authToken }
            .asSingle()
            .debug("refresh")
    }

    public func signOut() -> Single<Void?> {
        let googleInstance = GIDSignIn.sharedInstance()!
        googleInstance.disconnect()
        googleInstance.signOut()
        return self.signOutResultSubject
            .take(1)
            .asSingle()
    }
}

extension GoogleSignInManagerImpl: GoogleSignInProxyDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Swift.Error!) {
        if let error = error {
            print("signIn error:", error)
            signInResultSubject.onError(error)
            return
        }

        let result = GoogleUserInfo(
            id: user.userID!,
            authToken: user.authentication.accessToken!,
            name: user.profile!.name
        )
        print("signIn result:", result)
        signInResultSubject.onNext(result)
        refreshResultSubject.onNext(result)
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Swift.Error!) {
        if let error = error {
            print("signOUT error:", error)
            signOutResultSubject.onError(error)
            return
        }
        signOutResultSubject.onNext(())
    }
}
