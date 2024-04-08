import Core

protocol ErrorHandlerAbstract {
    func obtain(_ appError: ErrorWithContext) -> ErrorWithContext
}

// MARK: - ErrorHandler

final class ErrorHandler: ErrorHandlerAbstract {

    let session: SessionAbstract

    init(session: SessionAbstract) {
        self.session = session
    }

    func obtain(_ appError: ErrorWithContext) -> ErrorWithContext {
        guard case let .server(serverError) = appError.type else { return appError }

        switch (serverError.error.code, serverError.codeInt) {
        case (_, 401):
            session.handle(.logout(.init(needFlush: true, alert: nil)))
        default:
            break
        }
        return appError
    }
}
