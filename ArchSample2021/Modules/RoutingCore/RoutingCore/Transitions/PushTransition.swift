import UIKit

public class PushTransition: NSObject {
    var animator: Animator?
    var isAnimated: Bool = true
    var completionHandler: (() -> Void)?

    public weak var viewController: UIViewController?

    init(animator: Animator? = nil, isAnimated: Bool = true) {
        self.animator = animator
        self.isAnimated = isAnimated
    }
    
    deinit {
        print("Deinit PushTransition for:", viewController.self ?? "n/a")
    }
}

// MARK: - Transition

extension PushTransition: Transition {
    public func open(_ viewController: UIViewController) {
        self.viewController?.navigationController?.delegate = self
        self.viewController?.navigationController?.pushViewController(viewController, animated: isAnimated)
    }
  
    public func close(_ viewController: UIViewController) {
        self.viewController?.navigationController?.delegate = self
        self.viewController?.navigationController?.popViewController(animated: isAnimated)
    }
}

// MARK: - UINavigationControllerDelegate

extension PushTransition: UINavigationControllerDelegate {
    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool)
    {
        completionHandler?()
    }
  
    public func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        animator?.isPresenting = operation == .push
        return animator
    }
    
}
