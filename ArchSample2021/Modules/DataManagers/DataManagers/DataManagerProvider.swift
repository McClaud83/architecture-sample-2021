import Foundation

public enum DataManagerProvider {
    public static var storageManager: StorageManager {
        StorageManagerImpl()
    }
    
    public static var contactsManager: ContactsManager {
        ContactsManagerImpl()
    }
}
