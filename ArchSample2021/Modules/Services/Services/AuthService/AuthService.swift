import Foundation
import RxSwift

public protocol AuthService {
    func isUserAuthorised() -> Single<Bool>
    func signInWithGoogle(on viewController: UIViewController) -> Single<Void>
    func refreshToken(on viewController: UIViewController) -> Single<Void>
    func signOut() -> Single<Void>
}
