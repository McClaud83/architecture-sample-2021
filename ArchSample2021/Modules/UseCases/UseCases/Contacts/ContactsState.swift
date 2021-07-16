import Foundation
import Models
import Constants

public struct ContactsState {
    /// Активность
    public var fetchContactsState: ActiveState = .none
    public var logoutState: ActiveState = .none
    
    public var route: ContactsRoutes = .none
    
    public var contacts: [Contact]? = nil
}

extension ContactsState {
    typealias State = ContactsState
    static func reduce(state: State, event: ContactsEvent) -> State {
        var state = state
        switch event {
        case .reload:
            state.fetchContactsState = .inProgress
        
        case .failed(let error):
            switch error {
            case Errors.Network.unauthorized:
                state.route = .signIn
                
            default: break
            }
            state.fetchContactsState = .failed(error)
            state.logoutState = .failed(error)
            
        case .contacts(let contacts):
            state.fetchContactsState = .success
            state.contacts = contacts
            
        case .logout:
            state.logoutState = .inProgress
            
        case .logedout:
            state.route = .signIn
            state.logoutState = .success
        }
        return state
    }
}

