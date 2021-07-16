import Foundation
import GoogleSignIn

protocol GoogleSignInProxyDelegate: class {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Swift.Error!)
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Swift.Error!)
}

class GoogleSignInProxy: NSObject, GIDSignInDelegate {
    weak var delegate: GoogleSignInProxyDelegate?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        delegate?.sign(signIn, didSignInFor: user, withError: error)
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        delegate?.sign(signIn, didDisconnectWith: user, withError: error)
    }
}
