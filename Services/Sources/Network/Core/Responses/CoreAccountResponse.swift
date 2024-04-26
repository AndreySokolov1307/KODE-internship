import Foundation

public struct CoreAccountResponse: Decodable {

    public enum Status: String, Decodable {
        case active = "Активен"
    }

    public let number: String
    public let status: Status
    public let balance: Int
    public let currency: Currency
    public let accountId: Int
}
