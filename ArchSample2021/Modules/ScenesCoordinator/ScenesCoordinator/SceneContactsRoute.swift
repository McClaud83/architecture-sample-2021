import Foundation
import RoutingCore
import SceneContacts

extension RoutingCore.SceneContactsRoute where Self: RouterProtocol {
    public func showContactsScene() {
        let transition = WindowNavigationTransition()
        let module = SceneContactsModule(
            router: SceneContactsRouterImpl(),
            transition: transition
        )
        
        open(module.view, transition: transition)
    }
}

final class SceneContactsRouterImpl: Router2, SceneContactsRouter { }
