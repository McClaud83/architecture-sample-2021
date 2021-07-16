import UIKit

public protocol Closable: class {
    func close()
}

public protocol RouterProtocol: class {
    associatedtype GenericController: UIViewController
    var viewController: GenericController? { get }
    var openTransition: Transition? { get set }

    func open(_ viewController: UIViewController, transition: Transition)
    func close()
}


public protocol NonGenericRouterProtocol: class {
    var viewController: UIViewController? { get set }
    var openTransition: Transition? { get set }

    func open(_ viewController: UIViewController, transition: Transition)
    func close()
}
