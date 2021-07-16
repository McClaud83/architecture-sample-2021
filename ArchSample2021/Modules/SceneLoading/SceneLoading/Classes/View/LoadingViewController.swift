import UIKit
import RxSwift
import RxCocoa
import RxViewController
import Extensions

final class LoadingViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: LoadingViewModel!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Private properties
    var props = Props.none
    
    init(dependencies: Dependencies) {
        self.viewModel = dependencies.viewModel
        let bundle = Bundle(for:LoadingViewController.self)
        super.init(nibName: String(describing: Self.self), bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOutput()
    }
    
    func setupOutput() {
        let reloadTrigger = self.rx.viewDidAppear
            .asDriver()
            .mapToVoid()
        
        let input = LoadingViewModel.Input(
            disposeBag: disposeBag,
            reloadTrigger: reloadTrigger
        )
        viewModel.transform(input) { [weak self] in self?.setupInput(input: $0) }
    }
    
    func setupInput(input: LoadingViewModel.Output) {
        input.props
            .subscribe(onNext: { [weak self] in self?.render(props: $0) })
            .disposed(by: disposeBag)
    }
}

// MARK: - Props

extension LoadingViewController {
    enum Props: Equatable {
        case none
        case inProgress
    }
    
    // MARK: Render
    func render(props: Props) {
        self.props = props
        switch props {
        case .inProgress:
            activityIndicator?.startAnimating()
        case .none:
            activityIndicator?.stopAnimating()
        }
    }
}

// MARK: - DI

extension LoadingViewController {
    struct Dependencies {
        let viewModel: LoadingViewModel!
    }
}
