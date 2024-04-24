import Alamofire
import Pathfinder_Swift

public protocol Network {
    var sessionManager: Alamofire.Session { get }
    var refresherSessionManager: Session { get }
    var errorParser: ErrorParser { get }
    var defaultQueue: DispatchQueue { get }
    var environment: Environment { get }
    var session: SessionAbstract { get }

    func set(environment: Environment)
}

final class NetworkLayer: Network {

    let session: SessionAbstract
    var environment: Environment

    init(session: SessionAbstract,
         environment: Environment) {
        self.session = session
        self.environment = environment
        setupPathfinder()
    }

    func set(environment: Environment) {
        self.environment = environment
    }

    lazy var sessionManager: Alamofire.Session = {
        let manager = Alamofire.Session(
            configuration: urlSessionConfiguration,
            requestQueue: defaultQueue,
            interceptor: baseInterceptor,
            serverTrustManager: serverTrustPolicyManager
        )
        return manager
    }()

    lazy var refresherSessionManager: Session = {
        let manager = Session(
            configuration: urlSessionConfiguration,
            serverTrustManager: serverTrustPolicyManager
        )
        return manager
    }()

    lazy var errorHandler: ErrorHandlerAbstract = ErrorHandler(session: session)
    lazy var errorParser = ErrorParser(errorHandler: errorHandler)
    lazy var baseInterceptor = RequestInterceptor(
        environment: environment,
        session: session,
        sessionManager: refresherSessionManager,
        errorParser: errorParser,
        queue: defaultQueue
    )

    lazy var serverTrustPolicyManager: ServerTrustManager = {
        var hosts = Server.allCases.map(\.host)

        let policiesAllDisable = hosts.map { ($0, DisabledTrustEvaluator()) }
        return ServerTrustManager(
            allHostsMustBeEvaluated: true,
            evaluators: Dictionary(
                policiesAllDisable,
                uniquingKeysWith: { (host, _) in host }
            )
        )
    }()

    lazy var urlSessionConfiguration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.timeoutIntervalForRequest = 60
        configuration.waitsForConnectivity = true
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        return configuration
    }()

    lazy var defaultQueue = DispatchQueue(label: "Requests queue", qos: .default, attributes: [.concurrent])
}

extension NetworkLayer {
    private func setupPathfinder() {
        let authSpecs = AuthPath.allCases.map {
            UrlSpec(
                id: $0.id,
                pathTemplate: $0.endpoint,
                httpMethod: $0.method.pathfinderHttpMethod,
                tag: $0.tag,
                name: $0.name,
                currentStoplightQueryParams: [:]
            )
        }

        let coreSpecs = CorePath.allCases.map {
            UrlSpec(
                id: $0.id,
                pathTemplate: $0.endpoint,
                httpMethod: $0.method.pathfinderHttpMethod,
                tag: $0.tag,
                name: $0.name,
                currentStoplightQueryParams: [:]
            )
        }

        let allSpecs = authSpecs + coreSpecs

        let initialEnvironmentIndex = loadEnvironment()?.rawValue ?? defaultEnvironment().rawValue
        let config = PFConfig(
            specs: allSpecs,
            environments: Environment.allCases.map {
                PFEnvironment(
                    id: UUID(),
                    name: $0.name,
                    baseUrl: $0.server.baseUrl,
                    queryParams: $0.availableQueryParams
                )
            },
            initialEnvironmentIndex: initialEnvironmentIndex
        )
        Pathfinder.shared.configure(config: config)
        Pathfinder.shared.delegate = self
    }

    private func defaultEnvironment() -> Environment {
        let environment: Environment
#if DEV
        environment = Environment.dev
#elseif INT
        environment = Environment.internal
#elseif EXT
        environment = Environment.external
#else
        environment = Environment.release
#endif
        return environment
    }
}

extension HttpMethod {
    var pathfinderHttpMethod: PFHttpMethod {
        switch self {
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

extension NetworkLayer: PathfinderStateDelegate {

    private static func environmentKey() -> String { "DI-Pathfinder-Environment" }

    func pathfinder(didReceiveUpdatedState state: PFState) {
        guard let envName = state.currentEnvironment?.name else {
            return
        }
        UserDefaultsService().save(string: envName, forKey: Self.environmentKey())
    }

    func loadEnvironment() -> Environment? {
        let envName = UserDefaultsService().loadString(forKey: Self.environmentKey())
        return envName.flatMap(Environment.named)
    }
}
