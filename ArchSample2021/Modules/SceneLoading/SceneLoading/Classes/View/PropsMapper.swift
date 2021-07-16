import Foundation
import UseCases

enum PropsMapper {
    static func map(from state: LoadingState) -> LoadingViewController.Props {
        switch state.activeState {
        case .none:
            return .none
            
        case .inProgress:
            return .inProgress
        
        case .success, .failed:
            return .none
        }
        
        return .none
    }
}
