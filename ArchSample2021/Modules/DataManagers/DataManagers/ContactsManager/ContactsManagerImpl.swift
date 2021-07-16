import Foundation
import RxSwift
import Models
import Networking

final class ContactsManagerImpl: ContactsManager {
    /// - note: Может заменить на как-нибудь UserProvider-протокол
    /// Пока решил не усложнять
    let provider: ContactsAPIService
    
    init() {
        self.provider = APIServiceProvider.contactsAPIService
    }

    func obtainContacts() -> Single<[Contact]> {
        return provider.obtainContacts()
    }
}
