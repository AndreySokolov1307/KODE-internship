import UI
import UIKit
import AppIndependent
import Combine

final class MainView: BackgroundPrimary {
    
    // MARK: - Public Properties

    var onNewProduct: VoidHandler?
    var onRefresh: VoidHandler?
    
    // MARK: - Private Properties
    
    private let tableView = BaseTableView()
    private let refreshControl = UIRefreshControl()
    private let addButton = ButtonPrimary(title: Main.openNewAccount)
    private lazy var dataSource = MainDataSource(tableView: tableView)

    // MARK: - Public Methods
    
    override func setup() {
        super.setup()
        body().embed(in: self)
        setupButton()
        setupRefreshControll()
    }
    
    public func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    // MARK: - Private Methods

    private func body() -> UIView {
        tableView
    }
    
    private func setupRefreshControll() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(didPullRefreshControll(_:)), for: .valueChanged)
    }
    
    @objc private func didPullRefreshControll(_ sender: UIRefreshControl) {
        onRefresh?()
    }

    private func setupButton() {
        addSubview(addButton)
        addButton
            .pinBottomToSafeArea(inset: 24)
            .pinHorizontalEdges(to: self, inset: 16)
            .onTap { [weak self] in
            self?.onNewProduct?()
        }
    }
}

// MARK: - Configurable

extension MainView: ConfigurableView {
    typealias Model = MainViewProps

    func configure(with model: MainViewProps) {
        dataSource.apply(sections: model.sections)
        endRefreshing()
    }
}
