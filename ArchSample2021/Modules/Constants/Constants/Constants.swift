import Foundation

public enum Constants {
    public static let GoogleContactsScope: String = "https://www.googleapis.com/auth/contacts"
    public static let ContactsListUrl: String = "https://www.google.com/m8/feeds/gal/65apps.com"

    public enum UserDefaultsKeys: String {
        case authToken
    }
}
