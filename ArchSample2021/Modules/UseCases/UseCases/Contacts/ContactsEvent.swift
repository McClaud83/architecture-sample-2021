import Foundation
import Models

/// События, которые влияют на статус юзкейса
enum ContactsEvent {
    /// Произошла ошибка при получении контактов
    case failed(Error)
    /// Перезагрузить данные
    case reload
    /// Получены контакты
    case contacts([Contact])
    /// Выйти
    case logout
    /// Юзер разлогинился
    case logedout
}

