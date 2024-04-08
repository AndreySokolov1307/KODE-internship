import Foundation

public extension AppSession {

    enum Event {
        case logout(AppSession.Action.LogoutProps.Alert?)
        case error // (ErrorViewModel.ErrorType)
        case loginError // (LoginProblemViewModel.LoginProblemType)
        case deeplinking // (Deeplink)

        case none
    }
}
