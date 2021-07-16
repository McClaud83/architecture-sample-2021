import Foundation

/// События, которые вляияют на статус юзкейса
enum SignInEvent {
    /// Произошла ошибка при авторизации юзера
    case failed(Error)
    /// Начать авторизацию юзера
    case authorize(viewController: UIViewController)
    /// Юзер успешно авторизован
    case authorized
}

