import Foundation

public struct AuthLoginResponse: Decodable {
    public let otpId: String
    public let otpCode: String
    public let otpLen: Int
}
