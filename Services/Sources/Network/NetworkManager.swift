import Alamofire
import Combine
import Core
import AppIndependent
import Pathfinder_Swift

// swiftlint:disable final_class line_length type_body_length force_unwrapping
typealias Headers = [String: String]

public class NetworkRequestManager {

    let errorParser: ErrorParserAbstract
    let sessionManager: Alamofire.Session
    let environment: Environment
    let queue: DispatchQueue?
    let session: SessionAbstract

    init(
        errorParser: ErrorParserAbstract,
        sessionManager: Alamofire.Session,
        environment: Environment,
        queue: DispatchQueue?,
        session: SessionAbstract
    ) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.environment = environment
        self.queue = queue
        self.session = session
    }

    @discardableResult
    public func request<T: Decodable>(
        path: Path,
        pathParams: Parameters = [:],
        queryParams: Parameters = [:],
        params: Parameters? = nil,
        headers: HTTPHeaders? = nil
    ) -> AppPublisher<T> {
        let url: URL

        let castedPathParams = castUrlComponents(dict: pathParams)
        let castedQueryParams = castUrlComponents(dict: queryParams)

        do {
            url = try Self.url(forPath: path, pathParameters: castedPathParams, queryParameters: castedQueryParams)
        } catch {
            Logger().error("Failed to create URL for \(path.endpoint): \(error.localizedDescription)")
            return Fail<T, ErrorWithContext>(error: ErrorWithContext(.internal, requestContext: path.requestContext)).eraseToAnyPublisher()
        }

        Logger().info("Request \(url)")

        let request = sessionManager
            .request(
                url,
                method: path.httpMethod,
                parameters: params,
                encoding: path.encoding,
                headers: headers,
                interceptor: nil,
                requestModifier: nil
            )
            .validate { [unowned errorParser] request, response, data in
                errorParser.parse(request: request, response: response, data: data, requestContext: path.requestContext)
            }

        let dataResponse = request
//            .debug()
            .publishDecodable(type: T.self)
            .value()
            .mapError { [unowned errorParser] afError in
                errorParser.parseAfError(afError, requestContext: path.requestContext)
            }
            .receive(on: DispatchQueue.main)

        return dataResponse.eraseToAnyPublisher()
    }

    @discardableResult
    public func requestWithModel<T: Decodable, P: Encodable>(path: Path, params: P? = nil, headers: HTTPHeaders? = nil) -> AppPublisher<T> {
        let url: URL
        do {
            url = try Self.url(forPath: path)
        } catch {
            Logger().error("Failed to create URL for \(path.endpoint): \(error.localizedDescription)")
            return Fail<T, ErrorWithContext>(error: ErrorWithContext(.internal, requestContext: path.requestContext)).eraseToAnyPublisher()
        }

        let parameters: Parameters?

        do {
            parameters = try dictionary(forObject: params)
        } catch {
            Logger().error("Failed to encode \(String(describing: P.self)) to [String: Any]")
            return Fail<T, ErrorWithContext>(error: ErrorWithContext(.internal, requestContext: path.requestContext)).eraseToAnyPublisher()
        }

        Logger().info("Request with model \(url)")

        let request = sessionManager
            .request(url,
                     method: path.httpMethod,
                     parameters: parameters,
                     encoding: path.encoding,
                     headers: headers,
                     interceptor: nil,
                     requestModifier: nil
            )
            .validate { [unowned errorParser] request, response, data in
                errorParser.parse(request: request, response: response, data: data, requestContext: path.requestContext)
            }

        let dataResponse = request
            .publishDecodable(type: T.self)
            .value()
            .mapError { [unowned errorParser] afError in
                errorParser.parseAfError(afError, requestContext: path.requestContext)
            }
            .receive(on: DispatchQueue.main)

        return dataResponse.eraseToAnyPublisher()
    }

    @discardableResult
    public func requestResponseless(
        path: Path,
        pathParams: Parameters = [:],
        queryParams: Parameters = [:],
        params: Parameters? = nil,
        headers: HTTPHeaders? = nil
    ) -> AppPublisher<Void> {
        let url: URL

        let castedPathParams = castUrlComponents(dict: pathParams)
        let castedQueryParams = castUrlComponents(dict: queryParams)

        do {
            url = try Self.url(forPath: path, pathParameters: castedPathParams, queryParameters: castedQueryParams)
        } catch {
            Logger().error("Failed to create URL for \(path.endpoint): \(error.localizedDescription)")
            return Fail<Void, ErrorWithContext>(error: ErrorWithContext(.internal, requestContext: path.requestContext)).eraseToAnyPublisher()
        }

        Logger().info("Request \(url)")

        let request = sessionManager
            .request(url,
                     method: path.httpMethod,
                     parameters: params,
                     encoding: path.encoding,
                     headers: headers,
                     interceptor: nil,
                     requestModifier: nil)
            .validate { [unowned errorParser] request, response, data in
                errorParser.parse(request: request, response: response, data: data, requestContext: path.requestContext)
            }

        let dataResponse = request
            .publishUnserialized()
            .value()
            .map { _ in () }
            .mapError { [unowned errorParser] afError in
                errorParser.parseAfError(afError, requestContext: path.requestContext)
            }
            .receive(on: DispatchQueue.main)

        return dataResponse.eraseToAnyPublisher()
    }

    @discardableResult
    public func requestResponselessWithModel<P: Encodable>(
        path: Path,
        pathParams: Parameters = [:],
        queryParams: Parameters = [:],
        params: P? = nil,
        headers: HTTPHeaders? = nil
    ) -> AppPublisher<Void> {
        let url: URL

        let castedPathParams = castUrlComponents(dict: pathParams)
        let castedQueryParams = castUrlComponents(dict: queryParams)

        do {
            url = try Self.url(forPath: path, pathParameters: castedPathParams, queryParameters: castedQueryParams)
        } catch {
            Logger().error("Failed to create URL for \(path.endpoint): \(error.localizedDescription)")
            return Fail<Void, ErrorWithContext>(error: ErrorWithContext(.internal, requestContext: path.requestContext)).eraseToAnyPublisher()
        }

        let parameters: Parameters?
        do {
            parameters = try dictionary(forObject: params)
        } catch {
            Logger().error("Failed to encode \(String(describing: P.self)) to [String: Any]")
            return Fail<Void, ErrorWithContext>(error: ErrorWithContext(.internal, requestContext: path.requestContext)).eraseToAnyPublisher()
        }

        Logger().info("Responseless Request With Model \(url)")

        let request = sessionManager
            .request(url,
                     method: path.httpMethod,
                     parameters: parameters,
                     encoding: path.encoding,
                     headers: headers,
                     interceptor: nil,
                     requestModifier: nil)
            .validate { [unowned errorParser] request, response, data in
                errorParser.parse(request: request, response: response, data: data, requestContext: path.requestContext)
            }

        let dataResponse = request
            .publishUnserialized()
            .value()
            .map { _ in () }
            .mapError { [unowned errorParser] afError in
                errorParser.parseAfError(afError, requestContext: path.requestContext)
            }
            .receive(on: DispatchQueue.main)

        return dataResponse.eraseToAnyPublisher()
    }

    @discardableResult
    public func download(path: Path, headers: HTTPHeaders? = nil) -> AppPublisher<Data> {
        let url: URL
        do {
            url = try Self.url(forPath: path)
        } catch {
            Logger().error("Failed to create URL for \(path.endpoint): \(error.localizedDescription)")
            return Fail<Data, ErrorWithContext>(error: ErrorWithContext(.internal, requestContext: path.requestContext)).eraseToAnyPublisher()
        }

        Logger().info("Download \(url)")

        let request = sessionManager
            .request(url,
                     method: path.httpMethod,
                     parameters: nil,
                     encoding: path.encoding,
                     headers: headers,
                     interceptor: nil,
                     requestModifier: nil)
            .validate { [unowned errorParser] request, response, data in
                errorParser.parse(request: request, response: response, data: data, requestContext: path.requestContext)
            }
//            .debug()

        let dataResponse = request
            .publishData()
            .value()
            .mapError { [unowned errorParser] afError in
                errorParser.parseAfError(afError, requestContext: path.requestContext)
            }
            .receive(on: DispatchQueue.main)

        return dataResponse.eraseToAnyPublisher()
    }

    private func castUrlComponents(dict: [String: Any]) -> [String: String] {
        var newDict: [String: String] = [:]

        dict.forEach { key, value in
            switch value {
            // TODO: Handle if value is a dictionary or array
            case let number as NSNumber:
                if String(cString: number.objCType) == "c" {
                    newDict[key] = number == 1 ? "true" : "false"
                } else {
                    newDict[key] = number.stringValue
                }
            case let bool as Bool:
                newDict[key] = bool ? "true" : "false"
            case let str as String:
                newDict[key] = str
            default:
                break
            }
        }

        return newDict
    }

    func dictionary<T: Encodable>(forObject object: T?) throws -> [String: Any]? {
        guard let object = object else {
            return nil
        }

        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(object)
        let dictionary = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] ?? [:]
        return dictionary
    }

    static func url(forPath path: Path) throws -> URL {
        let address = try Pathfinder.shared.buildUrl(
            id: path.id,
            pathParameters: [:],
            queryParameters: [:]
        )
        let url = URL(string: address)!
        return url
    }

    static func url(forPath path: Path, pathParameters: [String: String]?, queryParameters: [String: String]?) throws -> URL {
        let address = try Pathfinder.shared.buildUrl(
            id: path.id,
            pathParameters: pathParameters ?? [:],
            queryParameters: queryParameters ?? [:]
        )
        if let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = URL(string: encodedAddress)!
            return url
        } else {
            return URL(string: path.id)!
        }
    }
}

extension Request {

    func debug() -> Self {
        #if DEV || INT
        cURLDescription { [weak self] (text) in
            Logger().debug("Request:\n")
            Logger().debug(text)

            Logger().debug("\nResponse:\n")
            guard let response = self?.response
            else {
                Logger().debug("–")
                return
            }
            Logger().debug(response.description)
        }
        #endif
        return self
    }
}

protocol DataRequestAbstract {
    func cancel() -> Self
}

extension DataRequest: DataRequestAbstract {}
