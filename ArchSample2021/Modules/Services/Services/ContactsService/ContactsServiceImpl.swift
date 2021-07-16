import Foundation
import RxSwift
import Models
import DataManagers

public class ContactsServiceImpl: ContactsService {
    private let contactsManager: ContactsManager
    
    public init(contactsManager: ContactsManager) {
        self.contactsManager = contactsManager
    }
    
    public func obtainContacts() -> Single<[Contact]> {
        return contactsManager.obtainContacts()
    }
}
