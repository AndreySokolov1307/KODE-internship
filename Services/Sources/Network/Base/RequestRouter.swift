import Alamofire
import Foundation

/// Interface for declarative declaration of server requests
protocol RequestRouter: URLRequestConvertible {
    /// Server base URL
    var baseUrl: URL { get }
    /// Request path
    static var endPoint: String { get }
    /// Final request path with parameters
    static var path: String { get }
    /// File name with server response stub
    static var stub: String { get }
    /// Regular for OHTTPStubs, for matching stub and request
    static var stubPathMatches: String { get }
    /// Request Method
    static var method: HTTPMethod { get }
    /// Dictionary with parameters for header
    var headers: Headers? { get }
    /// Dictionary with parameters for the request
    var parameters: Parameters? { get }
    /// Full request url
    var fullUrl: URL { get }
    /// Type of parameter encoding
    var encoding: RequestRouterEncoding { get }
}

extension RequestRouter {
    var fullUrl: URL {
        return baseUrl.appendingPathComponent(Self.path)
    }

    var encoding: RequestRouterEncoding {
        let encoding: RequestRouterEncoding
        switch Self.method {
        case .get:
            encoding = .url
        case .post:
            encoding = .json
        case .put:
            encoding = .json
        default:
            encoding = .url
        }
        return encoding
    }

    public func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = Self.method.rawValue
        headers?.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        switch encoding {
        case .url:
            return try URLEncoding(boolEncoding: .literal).encode(urlRequest, with: parameters)
        case .json:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}

/// Options for coding parameters
///
/// - url: Parameters are encoded in url
/// - json: Parameters are encoded in a JSON object and sent in the request body
enum RequestRouterEncoding {
    case url
    case json
}
