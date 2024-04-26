//
//  AccountDetailViewProps.swift
//  AnyApp
//
//  Created by Андрей Соколов on 17.04.2024.
//

import Foundation

struct AccountDetailViewProps {

    enum Section: Hashable {
        case mainInfo(Item)
        case infoTab(Item)
        case list([Item])

        var items: [Item] {
            switch self {
            case .mainInfo(let item), .infoTab(let item):
                return [item]
            case .list(let items):
                return items
            }
        }
    }

    enum Item: Hashable {
        case headerShimmer(_ identifier: String = UUID().uuidString)
        case infoTabShimmer(_ identifier: String = UUID().uuidString)
        case accountInfoShimmer(_ identifier: String = UUID().uuidString)
        case transactionShimmer(_ identifier: String = UUID().uuidString)
        case header(HeaderView.Props)
        case accountInfo(AccountInfoView.Props)
        case tab(InfoTabView.Props)
        case transaction(TransactionView.Props)
        case action(InfoView.Props)
        case payment(PaymentView.Props)
    }

    let sections: [Section]
}
