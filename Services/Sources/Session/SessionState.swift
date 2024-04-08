import Combine
import Core

// swiftlint:disable final_class
public extension AppSession {
    class State {

        @Published public var flow: Flow = .entrance

        @Published public var tokens: State.Tokens

        public var quickAccess: QuickAccess.State

        public init(quickAccess: QuickAccess.State, tokens: State.Tokens) {
            self.quickAccess = quickAccess
            self.tokens = tokens
        }
    }
}

public extension AppSession.State {
    enum Flow {
        case entrance
        case mainFlow // (DeeplinkAbstract?)
    }
}

public extension AppSession.State {
    struct Tokens {
        let accessToken: String
        let refreshToken: String
        static let initial = Tokens(accessToken: "", refreshToken: "")
    }
}
