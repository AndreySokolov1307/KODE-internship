public enum Environment: Int, CaseIterable {
#if DEV || INT || EXT
    case dev
    case `internal`
    case external
#endif
    case release

    var name: String {
        switch self {
#if DEV || INT || EXT
        case .dev:
            return "dev"
        case .internal:
            return "internal"
        case .external:
            return "external"
#endif
        case .release:
            return "release"
        }
    }

    var server: Server {
        switch self {
#if DEV || INT || EXT
        case .dev:
            return .stoplight
        case .internal:
            return .dev
        case .external:
            return .stage
#endif
        case .release:
            return .prod
        }
    }

    var availableQueryParams: Set<String> {
#if DEV || INT || EXT
        switch server {
        case .stoplight:
            return ["__code", "__example"]
        default:
            return []
        }
#else
        return []
#endif
    }

    static func named(_ name: String) -> Environment? {
        return Self.allCases.first(where: { $0.name == name })
    }
}
