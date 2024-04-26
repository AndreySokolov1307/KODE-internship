import Foundation

public struct CoreAccountListResponse: Decodable {
    public let accounts: [Account]
}

public struct Account: Decodable {

    public enum Status: String, Decodable {
        case active = "Активен"
    }

    public let cards: [Card]
    public let number: String
    public let status: Status
    public let balance: Int
    public let currency: Currency
    public let accountId: Int
}

public struct Card: Decodable {

    public enum Status: String, Decodable {
        case active = "ACTIVE"
        case deactivated = "DEACTIVATED"
    }

    public enum CardType: String, Decodable {
        case physical
        case digital
    }

    public enum PaymentSystem: String, Decodable {
        case visa = "Visa"
        case masterCard = "MasterCard"
    }

    public let name: String
    public let number: String
    public let status: Status
    public let cardId: String
    public let cardType: CardType
    public let paymentSystem: PaymentSystem

    public enum CodingKeys: String, CodingKey {
       case name, number, status
        case cardId = "card_id"
        case cardType = "card_type"
        case paymentSystem = "payment_system"
    }
}
