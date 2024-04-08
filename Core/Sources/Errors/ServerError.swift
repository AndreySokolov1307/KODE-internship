import Foundation

public struct ServerError: Error, Decodable {

    public struct ErrorInfo: Decodable {

        // Add hete server error code
        public enum Code: String, Decodable {
            case unknown

            // Authorization
            case unauthorized = "Unauthorized"
            case forbidden = "Forbidden"

            // Common Errors
            case badRequest = "BadRequest"
            case notFound = "NotFound"
            case internalServerError = "InternalServerError"
            case badGateway = "BadGateway"
            case serviceUnavailable = "ServiceUnavailable"
            case gatewayTimeout = "GatewayTimeout"
        }

        public let code: Code
        public let description: String
    }

    public let requestId: String
    public var code: String
    public var codeInt: Int? { Int(code) }
    public let description: String
    public let error: ErrorInfo

    enum CodingKeys: String, CodingKey {
        case requestId, code, description, error
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        requestId = try container.decode(String.self, forKey: .requestId)
        description = try container.decode(String.self, forKey: .description)
        error = try container.decode(ErrorInfo.self, forKey: .error)
    }

    public init(code: ErrorInfo.Code) {
        requestId = ""
        self.code = ""
        description = ""
        self.error = ErrorInfo(code: code, description: "")
    }
}

extension ServerError: Equatable {
    public static func == (lhs: ServerError, rhs: ServerError) -> Bool {
        return lhs.error.code.rawValue == rhs.error.code.rawValue
    }

    public func with(_ statusCode: Int) -> ServerError {
        var error = self
        error.code = String(statusCode)
        return error
    }
}

public protocol ErrorPayload: Decodable {}

public extension ServerError {
    struct Unknown: ErrorPayload {}
}
