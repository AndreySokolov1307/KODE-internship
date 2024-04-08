import Core

enum AuthPath: String, Path, CaseIterable {
    case login
    case confirm

    var id: String {
        switch self {
        case .login:
            return "login"
        case .confirm:
            return "confirm"
        }
    }

    public var endpoint: String {
        switch self {
        case .login:
            return "auth/login"
        case .confirm:
            return "auth/confirm"
        }
    }

    var method: HttpMethod { return .post }

    var requestContext: RequestContext {
        switch self {
        case .login:
            return .auth(.login)
        case .confirm:
            return .auth(.confirm)
        }
    }
}
