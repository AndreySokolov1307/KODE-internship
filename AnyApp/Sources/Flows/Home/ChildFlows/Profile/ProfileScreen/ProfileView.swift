import UI
import UIKit
import AppIndependent

final class ProfileView: BackgroundPrimary {

    var onLogout: VoidHandler?
    var onRefresh: VoidHandler?
    
    private let tableView = BaseTableView()
    private let refreshControl = UIRefreshControl()
    private lazy var dataSource = ProfileDateSource(tableView: tableView)

    override func setup() {
        super.setup()
        body().embed(in: self)
        tableView.refreshControl = refreshControl
        setupRefreshControll()
    }
    
    public func endRefreshing() {
        refreshControl.endRefreshing()
    }

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
