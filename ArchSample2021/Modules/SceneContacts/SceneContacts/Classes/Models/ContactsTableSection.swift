import Foundation
import Common
import Differentiator

struct ContactsTableSection: SectionModelType {
    typealias Item = ContactTableViewCell.Props
    var items: [ContactTableViewCell.Props]
    
    init(original: ContactsTableSection, items: [ContactTableViewCell.Props]) {
        self.items = items
    }
}
