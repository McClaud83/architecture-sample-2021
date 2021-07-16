import UIKit
import RoutingCore

public protocol SceneLoadingRouter:
    NonGenericRouterProtocol,
    Closable,
    SceneSignInRoute,
    SceneContactsRoute {
}
