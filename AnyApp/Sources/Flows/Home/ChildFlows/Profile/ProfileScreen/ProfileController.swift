import UI
import UIKit

final class ProfileController: TemplateViewController<ProfileView> {

    typealias ViewModel = ProfileViewModel
    
    enum Event {
        case appTheme
        case callSupport
        case about
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
        setupNavBar()
        viewModel.handle(.loadData)
    }
    
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
                self?.rootView.endRefreshing()
                self?.rootView.configure(with: props)
            case .about:
                self?.onEvent?(.about)
            case .theme:
                self?.onEvent?(.appTheme)
            case .support:
                self?.onEvent?(.callSupport)
            case .logOut:
                self?.showLogoutAllert()
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
