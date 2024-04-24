import Foundation

public struct CoreCardResponse: Decodable {

    public enum Status: String, Decodable {
        case active = "Активна"
    }

    public enum PaymentSystem: String, Decodable {
        case visa = "VISA"
        case masterCard = "MasterCard"
        case mir = "МИР"
    }

    public let id: Int
    public let name: String
    public let number: String
    public let status: Status
    public let accountId: Int
    public let expiredAt: String
    public let paymentSystem: PaymentSystem
}

extension CoreCardResponse.PaymentSystem {
//    var image: UIImage {
//        switch self {
//        case .visa:
//            return Asset.Images.
//        case .masterCard:
//            <#code#>
//        case .mir:
//            <#code#>
//        }
//    }
}
