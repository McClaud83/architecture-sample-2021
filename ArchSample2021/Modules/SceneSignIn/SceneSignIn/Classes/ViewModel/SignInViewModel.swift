import Foundation
import RxSwift
import RxCocoa
import UseCases

final class SignInViewModel {
    private let useCase: SignInUseCase
    private let router: SceneSignInRouter
    
    init(dependencies: Dependencies) {
        useCase = dependencies.useCase
        router = dependencies.router
    }
    
    func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {
        let state = useCase.signInState()

        let props = state.debug("signInState")
            .filter { [weak self] in self?.route(by: $0.route) == false }
            .map { state -> SignInViewController.Props in
                return PropsMapper.map(from: state)
            }
            .distinctUntilChanged()
        
        input.signInTrigger
            .drive { [useCase] controller in
                useCase.performSignIn(on: controller)
            }
            .disposed(by: input.disposeBag)
        
        outputHandler(
            Output(props: props)
        )
    }
}

// MARK: - Private

extension SignInViewModel {
    func route(by route: SignInRoutes) -> Bool {
        switch route {
        case .contacts:
            router.showContactsScene()
            return false
            
        default: break
        }
        return true
    }
}

// MARK: - Containers

extension SignInViewModel {
    struct Dependencies {
        let useCase: SignInUseCase
        let router: SceneSignInRouter
    }
    
    struct Input {
        let disposeBag: DisposeBag
        let signInTrigger: Driver<UIViewController>
    }

    struct Output {
        let props: Observable<SignInViewController.Props>
    }
}
