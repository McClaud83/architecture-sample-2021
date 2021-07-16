import Foundation

/// Стейт прохождения этапа "загрузка"
public struct LoadingState {
    /// Активность
    public var activeState: ActiveState = .none
//    /// Токен авторизации
//    var authToken: String?
    /// Совершить переход к экрану
    public var route: LoadingRoutes = .none
}

extension LoadingState {
    typealias State = LoadingState
    static func reduce(state: State, event: LoadingEvent) -> State {
        var state = state
        switch event {
        case .fetchAuthorizationStatus:
            state.activeState = .inProgress
            
        case .userAuthorized:
            state.route = .contactsList
            state.activeState = .success
            
        case .userNotAuthorized:
            state.route = .authorization
            state.activeState = .success
        }
        return state
    }
}
