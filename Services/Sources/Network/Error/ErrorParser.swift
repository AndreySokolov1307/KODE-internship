import Alamofire
import AppIndependent
import Core

// MARK: - ErrorParserAbstract

protocol ErrorParserAbstract: AnyObject {

    typealias ValidationResult = Request.ValidationResult

    func parseAfError(_ error: AFError, requestContext: RequestContext) -> ErrorWithContext
    func parse(request: URLRequest?, response: HTTPURLResponse, data: Data?, requestContext: RequestContext) -> ValidationResult
}

// MARK: - ErrorParser

public final class ErrorParser: ErrorParserAbstract {

    let errorHandler: ErrorHandlerAbstract

    init(errorHandler: ErrorHandlerAbstract) {
        self.errorHandler = errorHandler
    }

    func parseAfError(_ afError: AFError, requestContext: RequestContext) -> ErrorWithContext {
        Logger().log(String(describing: afError), eventLevel: .error)
        switch afError {
        case .responseSerializationFailed:
            return ErrorWithContext(.serverSendWrongData, requestContext: requestContext)

        case .responseValidationFailed(let reason):
            switch reason {
            case .customValidationFailed(let error):
                if let appError = error as? ErrorWithContext {
                    return errorHandler.obtain(appError)
                }
            default:
                break
            }

        case .serverTrustEvaluationFailed:
            return ErrorWithContext(.network, requestContext: requestContext)

        case .sessionTaskFailed(let error):
            let code = (error as NSError).code
            if code == -1001 || code == -1009 {
                return ErrorWithContext(.timeout, requestContext: requestContext)
            }

        default:
            break
        }

        return ErrorWithContext(.serverSendWrongData, requestContext: requestContext)
    }

    func parse(request _: URLRequest?, response: HTTPURLResponse, data: Data?, requestContext: RequestContext) -> ValidationResult {
        switch response.statusCode {
        case 200, 204, 205:
            return .success(())

        case 401, 403:
            return .failure(ErrorWithContext(.server(ServerError(code: .unauthorized)), requestContext: requestContext))

        default:
            if let data = data, !data.isEmpty {
                guard let error = try? JSONDecoder().decode(ServerError.self, from: data) else {
                    return .failure(ErrorWithContext(.serverSendWrongData, requestContext: requestContext))
                }

                let appError = ErrorWithContext(error.with(response.statusCode), requestContext: requestContext)
                return .failure(appError)
            } else {
                return .failure(ErrorWithContext(.serverSendWrongData, requestContext: requestContext))
            }
        }
    }
}
