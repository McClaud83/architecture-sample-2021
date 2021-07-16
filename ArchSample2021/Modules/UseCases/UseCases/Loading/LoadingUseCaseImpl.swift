import Foundation
import RxSwift
import RxFeedback
import Services

public class LoadingUseCaseImpl: LoadingUseCase, LoadingUseCaseEventStateUseCase {
    private let authService: AuthService
    private let feedbackPortSubject = PublishSubject<LoadingEvent>()
    
    private lazy var system: Observable<LoadingState> = makeState()
    
    // MARK: Lifecycle
    public init() {
        self.authService = ServiceProvider.authService()
    }
    
    // MARK: LoadingUseCaseStateUseCase
    
    public func loadingState() -> Observable<LoadingState> {
        return system
    }
    
    // MARK: LoadingUseCaseEventStateUseCase

    public func obtainUserToken() {
        feedbackPortSubject.onNext(.fetchAuthorizationStatus)
    }
    
    /// Прокся для прокидывания эвентов стейта
    private func feedbackPort() -> FeedbackLoop {
        return { $0.flatMapLatest { [weak self] _ in
            self?.feedbackPortSubject ?? PublishSubject<LoadingEvent>()
            }
        }
    }
}

private extension LoadingUseCaseImpl {
    /// Подготовить стейт
    func makeState() -> Observable<LoadingState> {
        return Observable
            .system(
                initialState: LoadingState(),
                reduce: LoadingState.reduce,
                scheduler: MainScheduler.instance,
                feedback: [
                    feedbackPort(),
                    authFeedbackLoop(),
                ]
            )
            .share(replay: 1, scope: .forever)
    }

    
    func authFeedbackLoop() -> FeedbackLoop {
        react { state -> Int? in
            if case let ActiveState.inProgress = state.activeState  { return 1 }
            return nil
        }
        effects: { [authService] _ -> Observable<LoadingEvent> in
          return authService
            .isUserAuthorised()
            .asObservable()
            .map { isAuthorized -> LoadingEvent in
                isAuthorized ?
                    LoadingEvent.userAuthorized :
                    LoadingEvent.userNotAuthorized
            }
        }
    }
}

// MARK: - Nested types

extension LoadingUseCaseImpl {
  /// FeedbackLoop
  typealias FeedbackLoop = (ObservableSchedulerContext<LoadingState>) -> Observable<LoadingEvent>
}

