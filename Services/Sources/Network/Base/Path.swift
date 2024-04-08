import Core
import Alamofire

public protocol Path: ContextProvider {
    var id: String { get }

    var endpoint: String { get }
    var method: HttpMethod { get }
}

extension Path {

    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        case .post:
            return JSONEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    var httpMethod: Alamofire.HTTPMethod {
        switch method {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .patch:
            return .patch
        case .delete:
            return .delete
        }
    }
}

// MARK: - Pathfinder support
extension AuthPath {

    var name: String {
        switch self {
        case .login:
            return "Post Login"

        case .confirm:
            return "Post Confirm"
        }
    }

    var tag: String { "Auth" }
}
