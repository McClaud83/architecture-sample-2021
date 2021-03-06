import Foundation
import RxSwift
import Extensions
import ErrorTracker
import GoogleSignInManager
import DataManagers

final class AuthServiceImpl: AuthService {
    private let storageService: StorageManager
    private let signInService: GoogleSignInManager
    private let errorTracker = ErrorTracker()
    private let disposeBag = DisposeBag()
  
    init(storageService: StorageManager, signInService: GoogleSignInManager) {
        self.storageService = storageService
        self.signInService = signInService
        
        errorTracker.asDriver()
            .drive()
            .disposed(by: disposeBag)
    }
  
    func isUserAuthorised() -> Single<Bool> {
        return storageService
            .obtainUserToken()
            .map { token -> Bool in
                return token != nil
            }
    }
    
    func signInWithGoogle(on viewController: UIViewController) -> Single<Void> {
        return signInService
            .signIn(on: viewController)
            .trackError(errorTracker)
            .catchErrorJustReturn(nil)
            .ignoreNil()
            .asSingle()
            .flatMap { [weak self] info -> Single<Void> in
                guard let self = self else { return Single.never() }
                
                print(#fileID, #function, "\nauthToken:", info.authToken)
                return self.storageService.storeUserToken(info.authToken)
            }
    }
    
    func refreshToken(on viewController: UIViewController) -> Single<Void> {
        return signInService
            .refreshToken(on: viewController)
            .trackError(errorTracker)
            .catchErrorJustReturn(nil)
            .ignoreNil()
            .asSingle()
            .flatMap { [weak self] newToken -> Single<Void> in
                guard let self = self else { return Single.never() }
                
                return self.storageService.storeUserToken(newToken)
            }
    }
    
    func signOut() -> Single<Void> {
        return signInService
            .signOut()
            .flatMap { [weak self] _ in
                guard let self = self else { return Single.never() }
                
                return self.storageService.storeUserToken(nil)
            }
    }
}
