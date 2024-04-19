import UI
import UIKit

final class ProfileController: TemplateViewController<ProfileView> {

    typealias ViewModel = ProfileViewModel
    
    enum Event {
        case appTheme
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
        viewModel.handle(.loadProfile)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func setupBindings() {
        viewModel.onOutput = { [weak self] output in
            switch output {
            case .content(let props):
                self?.rootView.configure(with: props)
            case .theme:
                self?.onEvent?(.appTheme)
            }
        }
        
        rootView.onLogout = { [weak self] in
            self?.viewModel.handle(.logout)
        }
    }
}
