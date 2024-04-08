import Alamofire
import Combine
import AppIndependent
import Core

final class RequestInterceptor: Alamofire.RequestInterceptor {

    private let lock = NSLock()
    private var isRefreshing = CurrentValueSubject<Bool, Never>(false)

    private let environment: Environment
    private let session: AppSession?
    private var cancellables = Set<AnyCancellable>()

    init(
        environment: Environment,
        session: SessionAbstract,
        sessionManager: Alamofire.Session,
        errorParser: ErrorParser,
        queue: DispatchQueue
    ) {
        self.environment = environment
        self.session = session as? AppSession
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest

        // FIXME: headers
        if let accessToken = self.session?.storage.accessToken {
            urlRequest.setValue(accessToken, forHTTPHeaderField: HeaderKey.authorization)
        } else {
#if DEV || INT || EXT
            if urlRequest.url?.host == Server.stoplight.host {
                urlRequest.setValue("ios_token_stub", forHTTPHeaderField: HeaderKey.authorization)
            }
#endif
        }

        urlRequest.setValue("IOS", forHTTPHeaderField: HeaderKey.platform)
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKey.contentType)

        urlRequest.setValue(UIDevice.current.systemVersion, forHTTPHeaderField: HeaderKey.platformVersion)

        let date = Date().timeIntervalSince1970
        urlRequest.setValue(date.description, forHTTPHeaderField: HeaderKey.date)

        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            urlRequest.setValue(version, forHTTPHeaderField: HeaderKey.appVersion)
        }

        completion(.success(urlRequest))
    }

    public func retry(_ request: Request,
                      for session: Session,
                      dueTo error: Error,
                      completion: @escaping (RetryResult) -> Void) {
        if
            let afError = error.asAFError,
            case .responseValidationFailed(let reason) = afError,
            case .customValidationFailed(let error) = reason,
            let errorWithContext = error as? ErrorWithContext {
            let appError = errorWithContext.appError
            if let serverError = appError.serverError {
                if case .unauthorized = serverError.error.code {
                    // FIXME: implement session refresh
//                    tryRefreshSession(completion: completion)
                    return
                }
            }
        }

        completion(.doNotRetry)
    }
}
