import UI
import UIKit
import Combine

final class AppThemeController: TemplateViewController<AppThemeView> {

    typealias ViewModel = AppThemeViewModel
    
    // MARK: - Private Properties
    
    private var viewModel: ViewModel!
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - AppThemeController

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    // MARK: - Public Methods

    override func setup() {
        super.setup()
        setupBindings()
        configureNavigationItem()
    }
    
    // MARK: - Private Methods
    
    private func configureNavigationItem() {
        navigationItem.title = Profile.Theme.title
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func setupBindings() {
        rootView.onThemeChanged = { [weak self] theme in
            self?.viewModel.handle(.themeChoosen(theme))
        }
        
        viewModel.currentTheme
            .removeDuplicates()
            .sink { theme in
                AppearanceManager.shared.setTheme(theme)
            }
            .store(in: &cancellable)
        
        AppearanceManager.shared.$themeRaw
            .removeDuplicates()
            .sink { [weak self] theme in
                self?.rootView.selectOption(with: theme)
            }
            .store(in: &cancellable)
    }
}

