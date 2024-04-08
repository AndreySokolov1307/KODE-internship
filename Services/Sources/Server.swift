public enum Server: CaseIterable {
#if DEV || INT || EXT
    case stoplight
    case dev
    case stage
#endif
    case prod

    public var host: String {
        switch self {
#if DEV || INT || EXT
        case .stoplight:
            return "stoplight.io"
        case .dev:
            return ""
        case .stage:
            return ""
#endif
        case .prod:
            return ""
        }
    }

    public var baseUrl: String {
        switch self {
#if DEV || INT || EXT
        case .stoplight:
            return "\(transferProtocol)://stoplight.io/mocks/kode-api/kode-bank/151956/api/"
        case .dev:
            return ""
        case .stage:
            return ""
#endif
        case .prod:
            return ""
        }
    }

    var transferProtocol: String {
        return "https"
    }

    var port: Int? {
        switch self {
#if DEV || INT || EXT
        case .stoplight, .dev, .stage:
            return nil
#endif
        case .prod:
            return nil
        }
    }
}
