import UI
import UIKit
import AppIndependent

final class ProfileView: BackgroundPrimary {

    var onLogout: VoidHandler?
    
    private let tableView = BaseTableView()
    private lazy var dataSource = ProfileDateSource(tableView: tableView)

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
            tableView
    }
}

extension ProfileView: ConfigurableView {
    typealias Model = ProfileViewProps
    
    func configure(with model: ProfileViewProps) {
        dataSource.apply(sections: model.sections)
    }
}
