import Foundation
import RxSwift
import RxFeedback
import Services

public class SignInUseCaseImpl: SignInUseCase, SignInUseCaseEventStateUseCase {
    private let authService: AuthService
    
    private let feedbackPortSubject = PublishSubject<SignInEvent>()
    
    private lazy var system: Observable<SignInState> = makeState()
    
    public init() {
        self.authService = ServiceProvider.authService()
    }
    
    // MARK: LoadingUseCaseStateUseCase
    
    public func signInState() -> Observable<SignInState> {
        return system
    }
    
    // MARK: LoadingUseCaseEventStateUseCase
    public func performSignIn(on viewcController: UIViewController) {
        feedbackPortSubject.onNext(.authorize(viewController: viewcController))
    }
    
    /// Прокся для прокидывания эвентов стейта
    private func feedbackPort() -> FeedbackLoop {
        return { $0.flatMapLatest { [weak self] _ in
            self?.feedbackPortSubject ?? PublishSubject<SignInEvent>()
            }
        }
    }
}

private extension SignInUseCaseImpl {
    /// Подготовить стейт
    func makeState() -> Observable<SignInState> {
        return Observable
            .system(
                initialState: SignInState(),
                reduce: SignInState.reduce,
                scheduler: MainScheduler.instance,
                feedback: [
                    feedbackPort(),
                    signInFeedbackLoop(),
                ]
            )
            .share(replay: 1, scope: .forever)
    }
    
    func signInFeedbackLoop() -> FeedbackLoop {
        react { state -> UIViewController? in
            return state.viewControllerToSignin
        }
        effects: { [authService] viewController -> Observable<SignInEvent> in
          return authService
            .signInWithGoogle(on: viewController)
            .asObservable()
            .debug("signInWithGoogle")
            .map { _ -> SignInEvent in
                return .authorized
            }
            .catchError { Observable.just(SignInEvent.failed($0.asDomain())) }
        }
    }
}

// MARK: - Nested types

extension SignInUseCaseImpl {
    /// FeedbackLoop
    typealias FeedbackLoop = (ObservableSchedulerContext<SignInState>) -> Observable<SignInEvent>
}

