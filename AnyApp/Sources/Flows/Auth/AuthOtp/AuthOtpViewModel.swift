import Services
import Combine

final class AuthOtpViewModel {

    enum Input {
        case otpEntered(String)
        case logout
    }

    enum Output {
        case userLoggedIn
        case wrongOtp(Int)
    }

    // MARK: - mock OTP
    
    private let mockOtp: String = "555555"
    private var otpAttemptsLeft = 5
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

    // TODO: - do it with real data later
    
    func handle(_ input: Input) {
        switch input {
        case .otpEntered(let otp):
            if isOtpValid(otp) {
                confirmOtp()
            } else {
                otpAttemptsLeft -= 1
                onOutput?(.wrongOtp(otpAttemptsLeft))
            }
        case .logout:
            appSession.handle(.logout(.init(needFlush: true, alert: .snack(message: "Вы разлогинились"))))
        }
    }
    
    private func isOtpValid(_ otp: String) -> Bool {
        return otp == mockOtp
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
