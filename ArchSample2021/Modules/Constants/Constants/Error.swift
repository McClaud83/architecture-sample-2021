import Foundation

public extension Swift.Error {
    public func asDomain() -> Error {
        switch self {
        case let domainErr as Error:
            return domainErr

        default:
            return Errors.CommonError.swiftError(self)
        }
    }
}

/// Базовая ошибка
public protocol Error: Swift.Error {
}

/// Нэймспейс ошибок
public enum Errors {
    /// Общие ошибки
    public enum CommonError: Error {
        /// Неизвестная ошибка
        case unkown
        /// Системная ошибка
        case systemError(String)
        /// Неизвестная swift ошибка
        case swiftError(Swift.Error)
    }
    
    public enum UserError: Error {
        case tokenIsExpired
    }
    
    /// Сетевые ошибки.
    public enum Network: Error {
        /// Нет инета
        case noInternet
        /// Сервер не отвечает
        case serverUnavailable
        /// Сервер вернул ошибку
        case serverError(String?)
        /// Неожиданный ответ сервера
        case badResponse
        /// Протухла авторизация
        case unauthorized
        /// Базовая ошибка от data слоя NSError
        case networkError(String)
    }
}
