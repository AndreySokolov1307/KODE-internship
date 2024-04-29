import UI
import UIKit

final class MainController: TemplateViewController<MainView> {

    typealias ViewModel = MainViewModel
    
    enum Event {
        case accountDetail(AccountDetailConfigModel)
        case cardDetail(CardDetailConfigModel)
    }
    
    // MARK: - Public Properties

    var onEvent: ((Event) -> Void)?
    
    // MARK: - Private Properties

    private var viewModel: ViewModel!
    
    // MARK: - MainController

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    // MARK: - Public Methods
    
    override func setup() {
        super.setup()
        setupBindings()
        configureNavigationItem()
        viewModel.handle(.loadData)
    }
    
    // MARK: - Private Methods

    private func configureNavigationItem() {
        navigationItem.title = Main.main
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func setupBindings() {
        rootView.onRefresh = { [weak self] in
            self?.viewModel.handle(.refreshData)
        }
        
        viewModel.onOutput = { [weak self] output in
            switch output {
            case .content(let props):
                self?.removeAdditionalState()
                self?.rootView.configured(with: props)
            case .accountDetail(let configModel):
                self?.onEvent?(.accountDetail(configModel))
            case .cardDetail(let configModel):
                self?.onEvent?(.cardDetail(configModel))
            case .error(let props):
                self?.setAdditionState(.error(props))
            case .errorMessage(let message):
                self?.rootView.endRefreshing()
                self?.showErrorSnack(with: message)
            }
        }

        rootView.onNewProduct = { 
            SnackCenter.shared.showInDevelopmentSnack()
        }
    }
}

