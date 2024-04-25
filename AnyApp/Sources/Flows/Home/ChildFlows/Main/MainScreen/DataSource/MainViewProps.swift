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
        case accountShimmer(_ identifier: String = UUID().uuidString)
        case headerShimmer(_ identifier: String = UUID().uuidString)
        case header(HeaderView.Props)
        case account(AccountView.Props)
        case card(AccountCardView.Props)
        case deposit(DepostiView.Props)
    }

    let sections: [Section]
}
