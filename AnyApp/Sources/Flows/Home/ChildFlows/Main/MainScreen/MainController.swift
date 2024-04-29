import UI
import UIKit

final class MainController: TemplateViewController<MainView> {

    typealias ViewModel = MainViewModel
    
    enum Event {
        case accountDetail(AccountDetailConfigModel)
        case cardDetail(CardDetailConfigModel)
    }

    var onEvent: ((Event) -> Void)?

    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func setup() {
        super.setup()
        setupBindings()
        configureNavigationItem()
        viewModel.handle(.loadData)
    }

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

