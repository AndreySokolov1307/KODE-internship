import UIKit
import Combine

public typealias AppPublisher<T> = AnyPublisher<T, ErrorWithContext>
public typealias AppResult<T> = Result<T, ErrorWithContext>
public typealias ResultPublisher<T> = AnyPublisher<AppResult<T>, Never>

public struct AppError: Error {

    public enum Kind: Equatable {
        case network
        case timeout
        case serverSendWrongData
        case server(ServerError)
        case `internal`
    }

    public let kind: Kind

    public var serverError: ServerError? {
        if case .server(let serverError) = kind {
            return serverError
        }
        return nil
    }

    public init(_ kind: Kind = .internal) {
        self.kind = kind
    }

    public init(_ serverError: ServerError) {
        self = AppError(.server(serverError))
    }
}
