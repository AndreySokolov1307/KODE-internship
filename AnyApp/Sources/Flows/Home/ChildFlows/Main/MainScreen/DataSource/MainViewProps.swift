//
//  MainViewProps.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import Foundation

struct MainViewProps {

    enum Section: Hashable {
        case accounts([Item])
        case deposits([Item])

        var items: [Item] {
            switch self {
            case .accounts(let items),
                 .deposits(let items):
                return items
            }
        }
    }

    enum Item: Hashable {
        case shimmer(_ identifier: String = UUID().uuidString)
        case header(TemplateHeaderView.Props)
        case account(TemplateView.Props)
        case card(TemplateView.Props)
        case deposit(TemplateView.Props)
    }

    let sections: [Section]
}
