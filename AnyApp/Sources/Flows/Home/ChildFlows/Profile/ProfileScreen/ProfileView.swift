import UI
import UIKit
import AppIndependent

final class ProfileView: BackgroundPrimary {
    
    // MARK: - Public Properties

    var onLogout: VoidHandler?
    var onRefresh: VoidHandler?
    
    // MARK: - Private Properties
    
    private let tableView = BaseTableView()
    private let refreshControl = UIRefreshControl()
    private lazy var dataSource = ProfileDataSource(tableView: tableView)

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

extension ProfileView: ConfigurableView {
    typealias Model = ProfileViewProps
    
    func configure(with model: ProfileViewProps) {
        dataSource.apply(sections: model.sections)
        endRefreshing()
    }
}
