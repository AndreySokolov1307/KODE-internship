//
//  InfoTabView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 17.04.2024.
//

import UIKit
import UI
import AppIndependent

final class InfoTabView: BackgroundPrimary {

    // MARK: - Private Properties
    
    private let refreshView = CircleView(sideLenght: 56)
    private let actionListView = CircleView(sideLenght: 56)
    private let paymentView = CircleView(sideLenght: 56)
    private(set) lazy var tabs = [refreshView, actionListView, paymentView]

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
    
        return HStack(distribution: .equalSpacing) {
            refreshView
                .image(Asset.Images.history.image)
                .onTap { [weak self] in
                    guard let self else { return }
                    self.selectTab(self.refreshView)
                    props.onTransaction()
                }
            actionListView
                .image(Asset.Images.list.image)
                .onTap { [weak self] in
                    guard let self else { return }
                    self.selectTab(self.actionListView)
                    props.onAction()
                }
            paymentView
                .image(Asset.Images.mainProduct.image)
                .onTap { [weak self] in
                    guard let self else { return }
                    self.selectTab(self.paymentView)
                    props.onPayment()
                }
        }.layoutMargins(.make(vInsets: 16, hInsets: 36))
    }
    
    private func setupTabs(with props: Props) {
        tabs.forEach {
            $0.backgroundStyle(.contentSecondary)
        }
        switch props.selectedTab {
        case .transactions:
            selectTab(refreshView)
        case .actions:
            selectTab(actionListView)
        case .payments:
            selectTab(paymentView)
        }
    }
    
    private func selectTab(_ tab: CircleView) {
        tabs.forEach { tab in
            tab.backgroundStyle(.contentSecondary)
                .foregroundStyle(.button)
        }
        tab.backgroundStyle(.buttonSecondary)
            .foregroundStyle(.buttonTab)
    }
}

// MARK: - Configurable

extension InfoTabView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        
        enum TabsType {
            case transactions
            case actions
            case payments
        }
        
        let id: String = UUID().uuidString
        let selectedTab: TabsType
        let onTransaction: VoidHandler
        let onAction: VoidHandler
        let onPayment: VoidHandler

        public static func == (lhs: InfoTabView.Props, rhs: InfoTabView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
        setupTabs(with: model)
        self.layoutIfNeeded()
    }
}
