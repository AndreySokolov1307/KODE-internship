import UI
import UIKit

final class CardDetailController: TemplateViewController<CardDetailView> {
    
    typealias ViewModel = CardDetailViewModel
    
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
        navigationItem.title = Main.CardDetail.title
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
                self.rootView.endRefreshing()
                self.rootView.configured(with: props)
            }
        }
    }
}
