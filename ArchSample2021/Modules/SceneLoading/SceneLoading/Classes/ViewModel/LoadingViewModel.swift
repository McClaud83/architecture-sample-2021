import Foundation
import RxSwift
import RxCocoa
import UseCases

final class LoadingViewModel {
    private let useCase: LoadingUseCase
    private let router: SceneLoadingRouter
    
    init(dependencies: Dependencies) {
        useCase = dependencies.useCase
        router = dependencies.router
    }
    
    func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {
        let state = useCase.loadingState()
        
        let props = state
            .filter { [weak self] in self?.route(by: $0.route) == false }
            .map { state -> LoadingViewController.Props in
                return PropsMapper.map(from: state)
            }
            .distinctUntilChanged()
        
        input.reloadTrigger
            .drive { [useCase] _ in
                useCase.obtainUserToken()
            }
            .disposed(by: input.disposeBag)
        
        outputHandler(
            Output(props: props)
        )
    }
}

// MARK: - Private

extension LoadingViewModel {
    func route(by route: LoadingRoutes) -> Bool {
        switch route {
        case .none:
            return false
            
        case .authorization:
            router.showSignInScene()
            return false
            
        case .contactsList:
            router.showContactsScene()
            return false
        }
        return true
    }
}

// MARK: - Containers

extension LoadingViewModel {
    struct Dependencies {
        let useCase: LoadingUseCase
        let router: SceneLoadingRouter
    }
    
    struct Input {
        let disposeBag: DisposeBag
        let reloadTrigger: Driver<Void>
    }

    struct Output {
        let props: Observable<LoadingViewController.Props>
    }
}
