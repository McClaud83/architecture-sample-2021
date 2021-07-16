import Foundation

/// События, которые вляияют на статус юзкейса
enum LoadingEvent {
    case fetchAuthorizationStatus
    case userAuthorized
    case userNotAuthorized
}
