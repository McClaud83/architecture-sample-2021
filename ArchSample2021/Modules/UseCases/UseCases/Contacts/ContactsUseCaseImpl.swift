import Foundation
import RxSwift
import RxFeedback
import Services

public class ContactsUseCaseImpl: ContactsUseCase, ContactsUseCaseEventStateUseCase {
    private let contactsService: ContactsService
    private let authService: AuthService
    
    private let feedbackPortSubject = PublishSubject<ContactsEvent>()
    
    private lazy var system: Observable<ContactsState> = makeState()
    
    public init() {
        self.contactsService = ServiceProvider.contactsService()
        self.authService = ServiceProvider.authService()
    }
    
    // MARK: LoadingUseCaseStateUseCase
    
    public func contactsState() -> Observable<ContactsState> {
        return system
    }
    
    // MARK: LoadingUseCaseEventStateUseCase
    public func fetchData() {
        feedbackPortSubject.onNext(.reload)
    }
    
    public func logout() {
        feedbackPortSubject.onNext(.logout)
    }
    
    /// Прокся для прокидывания эвентов стейта
    func feedbackPort() -> FeedbackLoop {
        return { [weak self] in
            $0.flatMapLatest { [weak self] _ in
                self?.feedbackPortSubject ?? PublishSubject<ContactsEvent>()
            }
        }
    }
}

private extension ContactsUseCaseImpl {
    /// Подготовить стейт
    func makeState() -> Observable<ContactsState> {
        return Observable
            .system(
                initialState: ContactsState(),
                reduce: ContactsState.reduce,
                scheduler: MainScheduler.instance,
                feedback: [
                    feedbackPort(),
                    fetchContactsLoop(),
                    signOutLoop(),
                ]
            )
            .share(replay: 1, scope: .forever)
    }
    
    func fetchContactsLoop() -> FeedbackLoop {
        react { state -> Int? in
            if case let ActiveState.inProgress = state.fetchContactsState  { return 1 }
            return nil
        }
        effects: { [contactsService] args -> Observable<ContactsEvent> in
            return contactsService
                .obtainContacts()
                .asObservable()
                .map { constacts -> ContactsEvent in
                    return .contacts(constacts)
                }
                .catchError { Observable.just(ContactsEvent.failed($0.asDomain())) }
        }
    }
    
    func signOutLoop() -> FeedbackLoop {
        react { state -> Int? in
            if case let ActiveState.inProgress = state.logoutState  { return 1 }
            return nil
        }
        effects: { [authService] args -> Observable<ContactsEvent> in
            return authService
                .signOut()
                .asObservable()
                .map { _ -> ContactsEvent in
                    return .logedout
                }
                .catchError { Observable.just(ContactsEvent.failed($0.asDomain())) }
        }
    }
    
}

// MARK: - Nested types

extension ContactsUseCaseImpl {
    /// FeedbackLoop
    typealias FeedbackLoop = (ObservableSchedulerContext<ContactsState>) -> Observable<ContactsEvent>
}

