import UIKit
import RoutingCore
import UseCases

public struct SceneContactsModule {
    public let view: UIViewController
    
    public init(router: SceneContactsRouter, transition: Transition?) {
        let useCase = ContactsUseCaseImpl()

        let viewModelDependencies = ContactsViewModel.Dependencies(
            useCase: useCase,
            router: router
        )
        let viewModel = ContactsViewModel(dependencies: viewModelDependencies)

        let viewDependencies = ContactsViewController.Dependencies(
            viewModel: viewModel
        )

        let view = ContactsViewController(dependencies: viewDependencies)
        router.viewController = view
        router.openTransition = transition

        self.view = view
    }
}
