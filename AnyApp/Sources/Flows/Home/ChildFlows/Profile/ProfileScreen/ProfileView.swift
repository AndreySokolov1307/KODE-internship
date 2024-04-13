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
        VStack {
            tableView
            Spacer(.px32)
            ButtonPrimary(title: "Разлогиниться")
                .onTap { [weak self] in
                    self?.onLogout?()
                }
        }.layoutMargins(.make(vInsets: 16, hInsets: 16))
    }
}

extension ProfileView: ConfigurableView {
    typealias Model = ProfileViewProps
    
    func configure(with model: ProfileViewProps) {
        dataSource.apply(sections: model.sections)
    }
}
