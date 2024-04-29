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
        case headerShimmer(_ identifier: String = UUID().uuidString)
        case cardShimmer(_ identifier: String = UUID().uuidString)
        case infoTabShimmer(_ identifier: String = UUID().uuidString)
        case transactionShimmer(_ identifier: String = UUID().uuidString)
        case header(HeaderView.Props)
        case card(CardInfoView.Props)
        case tab(InfoTabView.Props)
        case transaction(TransactionView.Props)
        case action(InfoView.Props)
        case payment(PaymentView.Props)
    }
    
    // MARK: - Public Properties

    let sections: [Section]
}
