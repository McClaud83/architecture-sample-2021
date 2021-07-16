import UIKit
import RoutingCore

public protocol SceneSignInRouter:
    NonGenericRouterProtocol,
    Closable,
    SceneContactsRoute {
}
