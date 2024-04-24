public protocol ContextProvider {
    var requestContext: RequestContext { get }
}

public enum RequestContext {
    case undefined
    case auth(AuthRequest)
    case core(CoreRequest)

    public enum AuthRequest {
        case login
        case confirm
    }

    public enum CoreRequest {
        case profile
        case accountList
        case depositList
        case account
        case card
    }
}
