import Foundation

public struct CoreDepositListResponse: Decodable {
    public let deposits: [Deposit]
}

public struct Deposit: Decodable {

    public enum Status: String, Decodable {
        case active = "ACTIVE"
        case deactivated = "DEACTIVATED"
    }

    public enum Currency: String, Decodable {
        case rub = "RUB"
    }

    public let name: String
    public let status: Status
    public let balance: Int
    public let currency: Currency
    public let depositId: Int
}
