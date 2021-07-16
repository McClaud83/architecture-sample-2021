import UIKit
import RxSwift
import RxCocoa
import Common

final class ContactTableViewCell: UITableViewCell {
    // MARK: Props
    struct Props: Equatable {
        let name: String
    }
    
    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure()
    }
    
    func render(props: Props) {
        nameLabel.text = props.name
    }
}

private extension ContactTableViewCell {
    func configure() {
        selectionStyle = .none
    }
}
