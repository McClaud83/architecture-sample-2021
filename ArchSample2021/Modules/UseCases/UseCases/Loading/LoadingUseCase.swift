import Foundation
import RxSwift

public protocol LoadingUseCase: LoadingUseCaseStateUseCase, LoadingUseCaseEventStateUseCase {
}

/// Стейт модуля "загрузка"
public protocol LoadingUseCaseStateUseCase {
    /// Стейт
    func loadingState() -> Observable<LoadingState>
}


/// Ивенты модуля "загрузка"
public protocol LoadingUseCaseEventStateUseCase {
    /// Получить токен пользователя
    func obtainUserToken()
}
