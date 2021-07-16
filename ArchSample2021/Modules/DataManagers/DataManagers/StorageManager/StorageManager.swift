import Foundation
import RxSwift

public protocol StorageManager {
    func obtainUserToken() -> Single<String?>
    func storeUserToken(_ token: String?) -> Single<Void>
}
