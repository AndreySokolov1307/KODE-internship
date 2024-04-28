import UI
import UIKit
import AppIndependent

final class CardDetailView: BackgroundPrimary {

    private let tableView = BaseTableView()
    private let refreshControl = UIRefreshControl()
    private lazy var dataSource = CardDetailDataSource(tableView: tableView)
    
    public var onRefresh: VoidHandler?

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

extension CardDetailView: ConfigurableView {
    typealias Model = CardDetailViewProps

    func configure(with model: CardDetailViewProps) {
        dataSource.apply(sections: model.sections)
        endRefreshing()
    }
}
