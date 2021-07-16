import UIKit
import Common
import Models
import RxSwift
import RxCocoa
import RxSwiftExtensions
import RxViewController
import Extensions
import RxDataSources

final class ContactsViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: ContactsViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var props = Props.none
    
    private lazy var dataSource = makeTableViewDataSource()
    private lazy var logoutBarButton = makeLogoutButton()

    init(dependencies: Dependencies) {
        self.viewModel = dependencies.viewModel
        let bundle = Bundle(for: Self.self)
        super.init(nibName: String(describing: Self.self), bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView(tableView, delegate: dataSource, bag: disposeBag)
        setupOutput()
    }
    
    func setupOutput() {
        let appearTrigger = self.rx.viewDidAppear.asDriver().mapToVoid()
            
        let reloadTrigger = Driver.merge(appearTrigger)
        
        let logoutTrigger = self.logoutBarButton.rx.tap.asDriver()
        
        let input = ContactsViewModel.Input(
            disposeBag: disposeBag,
            reloadTrigger: reloadTrigger,
            logoutTrigger: logoutTrigger
        )
        viewModel.transform(input) { [weak self] in self?.setupInput(input: $0) }
    }
    
    func setupInput(input: ContactsViewModel.Output) {
        input.props
            .subscribe(onNext: { [weak self] in self?.render(props: $0) })
            .disposed(by: disposeBag)
    }
}


// MARK: - Private methods

private extension ContactsViewController {
    func setupUI() {
        self.navigationController?.isNavigationBarHidden = false
        title = "Contacts"
        navigationItem.rightBarButtonItem = logoutBarButton
    }
    
    func setupTableView(_ tableView: UITableView, delegate: UITableViewDelegate, bag: DisposeBag) {
        tableView.registerCellNib(ContactTableViewCell.self)
        tableView.rx.setDelegate(delegate).disposed(by: bag)
        tableView.estimatedRowHeight = 72
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.rx.itemSelected
            .subscribe(
                onNext: { [tableView] indexPath in
                    tableView.deselectRow(at: indexPath, animated: true)
                }
            )
            .disposed(by: bag)
    }
    
    func makeTableViewDataSource() -> RxTableSectionWrapper<GenericSection<ContactTableViewCell.Props>> {
        let dataSource = RxTableSectionWrapper<GenericSection<ContactTableViewCell.Props>>(
            configureCell: { _, tv, ip, item -> UITableViewCell in
                let cell = tv.dequeueReusableCell(ofType: ContactTableViewCell.self, at: ip)
                cell.render(props: item)
                return cell
            }
        )
        return dataSource
    }
    
    func makeLogoutButton() -> UIBarButtonItem {
        return UIBarButtonItem(title: "Logout", style: .plain, target: nil, action: nil)
    }
}

// MARK: - Props

extension ContactsViewController {
    enum Props: Equatable {
        case none
        case contacts([GenericSection<ContactTableViewCell.Props>])
    }
    
    // MARK: Render
    
    func render(props: Props) {
        self.props = props
        switch props {
        case .contacts(let contactsProps):
            Observable.just(contactsProps)
                .bind(to: tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
            
        case .none:
            break
            
        }
        
    }
}

// MARK: - DI

extension ContactsViewController {
    public struct Dependencies {
        let viewModel: ContactsViewModel!
    }
}

