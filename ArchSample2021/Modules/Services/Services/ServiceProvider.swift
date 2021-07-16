import Foundation
import DataManagers
import GoogleSignInManager

public enum ServiceProvider {
    static public func authService() -> AuthService {
        AuthServiceImpl(
            storageService: DataManagerProvider.storageManager,
            signInService: GoogleSignInManagerImpl()
        )
    }
    
    static public func contactsService() -> ContactsService {
        ContactsServiceImpl(
            contactsManager: DataManagerProvider.contactsManager
        )
    }
}
