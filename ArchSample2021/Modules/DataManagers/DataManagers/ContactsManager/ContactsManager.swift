import Foundation
import RxSwift
import Models

public protocol ContactsManager {
    func obtainContacts() -> Single<[Contact]>
}
