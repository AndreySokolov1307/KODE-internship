import UI
import UIKit

final class AccountDetailController: TemplateViewController<AccountDetailView> {
    
    typealias ViewModel = AccountDetailViewModel
    
    // MARK: - Private Properties
    
    private var viewModel: ViewModel!
    
    // MARK: - AccountDetailController
    
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
        navigationItem.title = Main.accounts
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupBindings() {
        rootView.onRefresh = { [weak self] in
            self?.viewModel.handle(.refreshData)
        }
        
        viewModel.onOutput = { [weak self] output in
            guard let self else { return }
            
            switch output {
            case .content(let props):
                self.removeAdditionalState()
                self.rootView.configured(with: props)
            case .error(let props):
                self.setAdditionState(.error(props))
            case .errorMessage(let message):
                self.rootView.endRefreshing()
                self.showErrorSnack(with: message)
            }
        }
    }
}
