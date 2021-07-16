import Foundation
import RxSwift
import RxCocoa
import UseCases

final class ContactsViewModel {
    private let useCase: ContactsUseCase
    private let router: SceneContactsRouter
    
    init(dependencies: Dependencies) {
        useCase = dependencies.useCase
        router = dependencies.router
    }
    
    func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {
        let state = useCase.contactsState()
            .debug("ContactsState")

        let props = state
            .filter { [weak self] in self?.route(by: $0.route) == false }
            .map { state -> ContactsViewController.Props in
                return PropsMapper.map(from: state)
            }
            .distinctUntilChanged()
        
        input.reloadTrigger
            .drive(onNext: { [useCase] _ in
                useCase.fetchData()
            })
            .disposed(by: input.disposeBag)
        
        input.logoutTrigger
            .drive(onNext: { [useCase] _ in
                useCase.logout()
            })
            .disposed(by: input.disposeBag)
        
        outputHandler(
            Output(props: props)
        )
    }
}

// MARK: - Private

extension ContactsViewModel {
    func route(by route: ContactsRoutes) -> Bool {
        switch route {
        case .none:
            return false
            
        case .signIn:
            router.showSignInScene()
            return false
        }
        return true
    }
}

// MARK: - Containers

extension ContactsViewModel {
    struct Dependencies {
        let useCase: ContactsUseCase
        let router: SceneContactsRouter
    }
    
    struct Input {
        let disposeBag: DisposeBag
        let reloadTrigger: Driver<Void>
        let logoutTrigger: Driver<Void>
    }

    struct Output {
        let props: Observable<ContactsViewController.Props>
    }
}
