import Foundation
import RxSwift

public protocol ContactsUseCase: ContactsUseCaseStateUseCase, ContactsUseCaseEventStateUseCase {
}

/// Стейт юзкейса
public protocol ContactsUseCaseStateUseCase {
    /// Стейт
    func contactsState() -> Observable<ContactsState>
}


/// Ивенты юзкейса
public protocol ContactsUseCaseEventStateUseCase {
    func fetchData()
    func logout()
}

