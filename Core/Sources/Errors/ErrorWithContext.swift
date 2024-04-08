public struct ErrorWithContext: Error {

    public let appError: AppError
    public let requestContext: RequestContext

    public var serverError: ServerError? {
        return appError.serverError
    }
    public var type: AppError.Kind {
        return appError.kind
    }

    public init(appError: AppError, requestContext: RequestContext) {
        self.requestContext = requestContext
        self.appError = appError
    }

    public init(_ serverError: ServerError, requestContext: RequestContext) {
        appError = AppError(serverError)
        self.requestContext = requestContext
    }

    public init(_ errorType: AppError.Kind, requestContext: RequestContext) {
        appError = AppError(errorType)
        self.requestContext = requestContext
    }
}
