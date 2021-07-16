import Foundation

/// Стейт активностей
public enum ActiveState {
    /// неопределен
    case none
    /// в процессе загрузки
    case inProgress
    /// успешно загружен
    case success
    /// в процессе загрузки произошла ошибка
    case failed(Error)

    /// Ошибка если есть
    public var error: Error? {
        switch self {
        case .failed(let error):
            return error

        case .inProgress, .none, .success:
            return nil
        }
    }
}

