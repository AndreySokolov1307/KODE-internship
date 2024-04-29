import UI
import UIKit

final class ProfileController: TemplateViewController<ProfileView> {

    typealias ViewModel = ProfileViewModel
    
    enum Event {
        case appTheme
        case callSupport
        case about
    }

    // MARK: - Public Properties
    
    var onEvent: ((Event) -> Void)?
    
    // MARK: - Private Properties

    private var viewModel: ViewModel!
    
    // MARK: - ProfileController

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    // MARK: - Public Methods

    override func setup() {
        super.setup()
        setupBindings()
        setupNavBar()
        viewModel.handle(.loadData)
    }
    
    // MARK: - Private Methods
    
    private func setupNavBar() {
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
                self?.rootView.configure(with: props)
            case .about:
                self?.onEvent?(.about)
            case .theme:
                self?.onEvent?(.appTheme)
            case .support:
                self?.onEvent?(.callSupport)
            case .logOut:
                self?.showLogoutAllert()
            case .error(let props):
                self?.setAdditionState(.error(props))
            case .errorMessage(let message):
                self?.rootView.endRefreshing()
                self?.showErrorSnack(with: message)
            }
        }
        
        rootView.onLogout = { [weak self] in
            self?.viewModel.handle(.logout)
        }
    }
    
    private func showLogoutAllert() {
        let cancelAction = UIAlertAction(title: Common.cancel,
                                         style: .cancel)
        
        let logOutAction = UIAlertAction(title: Common.quit,
                                         style: .default,
                                         handler: { _ in
            self.viewModel.handle(.logout)
        })
        presentAlert(title: Profile.Quit.message,
                     message: nil,
                     actions: [cancelAction, logOutAction])
    }
}
