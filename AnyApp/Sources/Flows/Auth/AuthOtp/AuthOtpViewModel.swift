import Services
import Combine

final class AuthOtpViewModel {

    enum Input {
        case otpEntered(String)
    }

    enum Output {
        case userLoggedIn
    }

    var onOutput: ((Output) -> Void)?

    private let authRequestManager: AuthRequestManagerAbstract
    private let appSession: AppSession

    private var cancellables = Set<AnyCancellable>()

    init(
        authRequestManager: AuthRequestManagerAbstract,
        appSession: AppSession
    ) {
        self.authRequestManager = authRequestManager
        self.appSession = appSession
    }

    func handle(_ input: Input) {
        switch input {
        case .otpEntered:
            confirmOtp()
        }
    }

    private func confirmOtp() {
        authRequestManager.authConfirm(otpId: "", phone: "", otpCode: "")
            .sink(
                receiveCompletion: { _ in
                    // handle error
                }, receiveValue: { [weak self] response in
                    self?.appSession.handle(.updateTokens(
                        accessToken: response.guestToken,
                        refreshToken: ""
                    ))
                    self?.onOutput?(.userLoggedIn)
                }
            ).store(in: &cancellables)
    }
}
