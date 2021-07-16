import Foundation

public struct SignInState {
    /// Активность
    public var activeState: ActiveState = .none
    /// Переход из модуля
    public var route: SignInRoutes = .none
    
    public weak var viewControllerToSignin: UIViewController?
}

extension SignInState {
    typealias State = SignInState
    static func reduce(state: State, event: SignInEvent) -> State {
        var state = state
        switch event {
        case .authorize(let viewController):
            state.viewControllerToSignin = viewController
            state.activeState = .inProgress
            
        case .authorized:
            state.route = .contacts
            state.activeState = .success
        
        case .failed(let error):
            state.activeState = .failed(error)
        }
        return state
    }
}
