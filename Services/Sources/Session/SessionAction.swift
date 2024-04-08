import Foundation

public extension AppSession {
    enum Action {
        case login(login: String, otpId: String, seconds: Int)
        case updateTokens(accessToken: String, refreshToken: String)

        case finishVerify(pin: String)
        case logout(LogoutProps)

        case quickAccess(QuickAccess.Action)

        public struct LogoutProps {
            public enum Alert {
                case snack(message: String)
            }

            let needFlush: Bool
            let alert: Alert?

            public init(
                needFlush: Bool = false,
                alert: Alert? = nil
            ) {
                self.needFlush = needFlush
                self.alert = alert
            }
        }
    }

    func handle(_ action: Action) {
        switch action {
        case .updateTokens(let accessToken, let refreshToken):
            handleUpdateTokens(accessToken, refreshToken)
        case .finishVerify(let pin):
            handleFinishVerify(pin)
        case .logout(let props):
            handleLogout(props)
        case .quickAccess(let action):
            quickAccess.handle(action)
        case .login(let login, let otpId, let seconds):
            handeUpdateLoginCreds(login, otpId, seconds: seconds)
        }
    }
}

extension AppSession {
    func handeUpdateLoginCreds(_ login: String, _ otpId: String, seconds: Int) {
        storage.login = login
        storage.otpId = otpId
        storage.seconds = seconds
    }

    func handleUpdateTokens(_ accessToken: String, _ refreshToken: String) {
        storage.accessToken = accessToken
        storage.refreshToken = refreshToken
        state.tokens = State.Tokens(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }

    func handleFinishVerify(_ pin: String) {
        guard
            let accessToken = storage.accessToken,
            let refreshToken = storage.refreshToken
        else {
            return
        }
        quickAccess.handle(.updatePinInStorage(pin))
        state.tokens = State.Tokens(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
        state.quickAccess = quickAccess.state
    }

    func handleLogout(_ props: Action.LogoutProps) {
        if props.needFlush {
            storage.flush()
            quickAccess.handle(.logout)
        }

        state.tokens = State.Tokens.initial

        state.quickAccess = quickAccess.state
        state.flow = .entrance
        event = .logout(props.alert)
    }
}
