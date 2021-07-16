import Foundation
import RxSwift
import Models

public protocol ContactsService {
    func obtainContacts() -> Single<[Contact]>
}
