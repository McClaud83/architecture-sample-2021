import Foundation
import RxSwift

public protocol SignInUseCase: SignInUseCaseStateUseCase, SignInUseCaseEventStateUseCase {
}

/// Стейт юзкейса
public protocol SignInUseCaseStateUseCase {
    /// Стейт
    func signInState() -> Observable<SignInState>
}


/// Ивенты юзкейса
public protocol SignInUseCaseEventStateUseCase {
    func performSignIn(on viewcController: UIViewController)
}

