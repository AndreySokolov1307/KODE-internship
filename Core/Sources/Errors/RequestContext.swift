public protocol ContextProvider {
    var requestContext: RequestContext { get }
}

public enum RequestContext {
    case undefined
    case auth(AuthRequest)

    public enum AuthRequest {
        case login
        case confirm
    }
}
