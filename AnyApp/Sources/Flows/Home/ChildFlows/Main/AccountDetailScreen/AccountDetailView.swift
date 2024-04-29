import UI
import UIKit
import AppIndependent

final class AccountDetailView: BackgroundPrimary {
    
    // MARK: - PublicProperties
    
    public var onRefresh: VoidHandler?
    
    // MARK: - Private Properties

    private let tableView = BaseTableView()
    private let refreshControl = UIRefreshControl()
    private lazy var dataSource = AccountDetailDataSource(tableView: tableView)

    // MARK: - Public Methods
    
    override func setup() {
        super.setup()
        body().embed(in: self)
        tableView.refreshControl = refreshControl
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
        refreshControl.addTarget(self, action: #selector(didPullRefreshControll(_:)), for: .valueChanged)
    }
    
    @objc private func didPullRefreshControll(_ sender: UIRefreshControl) {
        onRefresh?()
    }
}

// MARK: - Configurable

extension AccountDetailView: ConfigurableView {
    typealias Model = AccountDetailViewProps

    func configure(with model: AccountDetailViewProps) {
        dataSource.apply(sections: model.sections)
        endRefreshing()
    }
}
