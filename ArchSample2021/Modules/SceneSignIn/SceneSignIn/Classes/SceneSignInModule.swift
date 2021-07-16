import UIKit
import RoutingCore
import UseCases

public struct SceneSignInModule {
    public let view: UIViewController
    
    public init(router: SceneSignInRouter, transition: Transition?) {
        let useCase = SignInUseCaseImpl()

        let viewModelDependencies = SignInViewModel.Dependencies(
            useCase: useCase,
            router: router
        )
        let viewModel = SignInViewModel(dependencies: viewModelDependencies)

        let viewDependencies = SignInViewController.Dependencies(
            viewModel: viewModel
        )

        let view = SignInViewController(dependencies: viewDependencies)
        router.viewController = view
        router.openTransition = transition

        self.view = view
    }
}
