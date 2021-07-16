import UIKit
import RxSwift
import RxCocoa
import RxSwiftExtensions
import RxViewController
import Extensions

final class SignInViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: SignInViewModel!
    
    @IBOutlet weak var signInButton: UIButton!
    
    var props = Props.none
    
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
        
        setupOutput()
    }
    
    func setupOutput() {
        let signInTrigger = signInButton.rx.tap
            .asDriver()
            .map { _ in self as UIViewController }
        
        let input = SignInViewModel.Input(
            disposeBag: disposeBag,
            signInTrigger: signInTrigger
            
        )
        viewModel.transform(input) { [weak self] in self?.setupInput(input: $0) }
    }
    
    func setupInput(input: SignInViewModel.Output) {
        input.props
            .subscribe(onNext: { [weak self] in self?.render(props: $0) })
            .disposed(by: disposeBag)
    }
}

// MARK: - Props

extension SignInViewController {
    enum Props: Equatable {
        case none
    }
    
    // MARK: Render
    
    func render(props: Props) {
        self.props = props
    }
}

// MARK: - DI

extension SignInViewController {
    public struct Dependencies {
        let viewModel: SignInViewModel!
    }
}
