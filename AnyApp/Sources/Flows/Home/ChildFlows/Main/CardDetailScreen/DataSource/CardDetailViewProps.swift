//
//  CardDetailViewProps.swift
//  AnyApp
//
//  Created by Андрей Соколов on 21.04.2024.
//

import Foundation

struct CardDetailViewProps {

    enum Section: Hashable {
        case card(Item)
        case infoTab(Item)
        case list([Item])

        var items: [Item] {
            switch self {
            case .card(let item), .infoTab(let item):
                return [item]
            case .list(let items):
                return items
            }
        }
    }

    enum Item: Hashable {
        case header(HeaderView.Props)
        case card(CardInfoView.Props)
        case tab(InfoTabView.Props)
        case transaction(TransactionView.Props)
        case action(InfoView.Props)
        case payment(PaymentView.Props)
    }

    let sections: [Section]
}
