import Foundation
import RoutingCore
import SceneSignIn

extension RoutingCore.SceneSignInRoute where Self: RouterProtocol {
    public func showSignInScene() {
        let transition = WindowNavigationTransition()
        let module = SceneSignInModule(
            router: SceneSignInRouterImpl(),
            transition: transition
        )
        
        open(module.view, transition: transition)
    }
}

final class SceneSignInRouterImpl: Router2, SceneSignInRouter { }
