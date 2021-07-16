import UIKit
import RoutingCore

public protocol AppRouter:
    Closable,
    SceneLoadingRoute {
}

public final class AppRouterImpl: RoutingCore.Router<UIViewController>, AppRouter {}
