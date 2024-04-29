import UIKit
import UI

final class ProfileDataSource {
    
    typealias Section = ProfileViewProps.Section
    typealias Item = ProfileViewProps.Item
    typealias DiffableDataSource = UITableViewDiffableDataSource<Section, Item>
    
    // MARK: - Private properties
    
    public var dataSource: DiffableDataSource?
    private let tableView: BaseTableView
    private let cellFactory: ProfileCellFactory
    
    // MARK: - ProfileDataSource
    
    init(tableView: BaseTableView) {
        self.tableView = tableView
        self.cellFactory = ProfileCellFactory(tableView: tableView)
        setup()
        configure()
    }
    
    // MARK: - Public Methods
    
    public func apply(sections: [Section]) {
        var snap = NSDiffableDataSourceSnapshot<Section, Item>()
        snap.appendSections(sections)
        sections.forEach {
            snap.appendItems($0.items, toSection: $0)
            dataSource?.apply(snap, animatingDifferences: false)
        }
    }
    
    // MARK: - Private methods
    
    private func setup() {
        tableView.contentInsets(.init(top: 16, left: 0, bottom: 16, right: 0))
        tableView.registerTemplateCell(forView: ProfileDetailShimmerView.self)
        tableView.registerTemplateCell(forView: InfoShimmerView.self)
        tableView.registerTemplateCell(forView: ProfileDetailView.self)
        tableView.registerTemplateCell(forView: InfoView.self)
    }
    
    private func configure() {
        dataSource = DiffableDataSource(tableView: tableView) { [unowned self] _, indexPath, item in
            switch item {
            case .profileShimmer:
                return cellFactory.makeProfileShimmer(for: indexPath)
            case .infoShimmer:
                return cellFactory.makeInfoShimmer(for: indexPath)
            case .profile(let props):
                return cellFactory.makeProfileDetailCell(for: indexPath, with: props)
            case .info(let props):
                return cellFactory.makeInfoCell(for: indexPath, with: props)
            }
        }
    }
}
