import Foundation
import UseCases
import Common

enum PropsMapper {
    static func map(from state: ContactsState) -> ContactsViewController.Props {
        if let contacts = contactCellProps(from: state) {
            return .contacts(contacts)
        }
        
        return .none
    }
    
    static func contactCellProps(from state: ContactsState) -> [GenericSection<ContactTableViewCell.Props>]? {
        guard let contacts = state.contacts else { return nil }
        
        let items = contacts.map { ContactTableViewCell.Props(name: $0.name) }
        return [GenericSection(title: "contacts", items: items)]
    }
}
