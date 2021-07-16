import Foundation
import RoutingCore
import SceneLoading

extension RoutingCore.SceneLoadingRoute where Self: RouterProtocol {
    public func showLoadingScene() {
        let transition = WindowNavigationTransition()
        let module = SceneLoadingModule(
            router: SceneLoadingRouterImpl(),
            transition: transition
        )

        open(module.view, transition: transition)
    }
}

final class SceneLoadingRouterImpl: Router2, SceneLoadingRouter { }
