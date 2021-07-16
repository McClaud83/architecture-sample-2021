import UIKit
import RoutingCore
import UseCases

public struct SceneLoadingModule {
    public let view: UIViewController
    
    public init(router: SceneLoadingRouter, transition: Transition?) {
        let useCase = LoadingUseCaseImpl()
        
        let viewModelDependencies = LoadingViewModel.Dependencies(
            useCase: useCase,
            router: router
        )
        let viewModel = LoadingViewModel(dependencies: viewModelDependencies)
        
        let viewDependencies = LoadingViewController.Dependencies(
            viewModel: viewModel
        )
        
        let view = LoadingViewController(dependencies: viewDependencies)
        router.viewController = view
        router.openTransition = transition
        
        self.view = view
    }
}
