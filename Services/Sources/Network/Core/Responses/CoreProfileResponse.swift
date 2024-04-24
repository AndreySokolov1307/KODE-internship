import Foundation

public struct CoreProfileResponse: Decodable {
    public let id: Int
    public let firstName: String
    public let middleName: String
    public let lastName: String
    public let country: String
    public let phone: String
}

public extension CoreProfileResponse {
    var fullName: String {
        firstName + " " + lastName
    }
}
