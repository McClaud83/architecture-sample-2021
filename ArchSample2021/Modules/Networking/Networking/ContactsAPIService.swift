import Foundation
import RxSwift
import Models
import Moya

public protocol ContactsAPIService {
    func obtainContacts() -> Single<[Contact]>
}

class ContactsAPIServiceImpl {
    let provider: MoyaProvider<ContactsAPI>
    init() {
        self.provider = MoyaProvider<ContactsAPI>(plugins: [
            AuthrisationTokePlugin()
        ])
    }
}

extension ContactsAPIServiceImpl: ContactsAPIService {
    func obtainContacts() -> Single<[Contact]> {
        return provider.rx.request(.contacts)
            .filterSuccessfulStatusCodes()
            .map(ContactsResponse.self)
            .map { response -> [Contact] in
                return response.feed.entry
                    .compactMap { entry -> Contact? in
                        let name = entry.name.fullName.value ?? String()
                        return Contact(
                            id: entry.id.value,
                            name: name
                        )
                    }
            }
            .catchError(ErrorHandler.handleError)
    }
}
