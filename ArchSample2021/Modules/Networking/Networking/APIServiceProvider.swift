import Foundation

public enum APIServiceProvider {
    public static var contactsAPIService: ContactsAPIService {
        ContactsAPIServiceImpl()
    }
}
