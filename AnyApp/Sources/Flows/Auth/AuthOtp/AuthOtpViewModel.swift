import Services
import Combine

final class AuthOtpViewModel {
    
    typealias ConfigModel = AuthOtpConfigModel

    enum Input {
        case otpEntered(String)
        case logout
        case otpRepeat
    }

    enum Output {
        case userLoggedIn
        case wrongOtp(String)
        case zeroAttemptsLeft
    }
    
    private var otpAttemptsLeft = 5
    var onOutput: ((Output) -> Void)?

    private var configModel: ConfigModel
    private let authRequestManager: AuthRequestManagerAbstract
    private let appSession: AppSession
    
    private var otpAttemptsLeftMessage: String {
        let attemptString = Plurals.attemptsLeft(otpAttemptsLeft)
        let leftString = Plurals.leftFem(otpAttemptsLeft)
        return ("Неверный код. \(leftString) \(otpAttemptsLeft) " + attemptString)
    }

    private var cancellables = Set<AnyCancellable>()

    init(
        configModel: AuthOtpConfigModel,
        authRequestManager: AuthRequestManagerAbstract,
        appSession: AppSession
    ) {
        self.configModel = configModel
        self.authRequestManager = authRequestManager
        self.appSession = appSession
    }
    
    func handle(_ input: Input) {
        switch input {
        case .otpEntered(let otp):
            if isOtpValid(otp) {
                confirmOtp()
            } else {
                otpAttemptsLeft -= 1
                onOutput?(.wrongOtp(otpAttemptsLeftMessage))
                if otpAttemptsLeft <= 0 {
                    onOutput?(.zeroAttemptsLeft)
                }
            }
        case .otpRepeat:
            otpRepeat()
        case .logout:
            appSession.handle(.logout(.init(needFlush: true, alert: .snack(message: "Вы разлогинились"))))
        }
    }
    
    private func isOtpValid(_ otp: String) -> Bool {
        return otp == configModel.otpCode
    }
    
    private func otpRepeat() {
        authRequestManager.authLogin(phone: configModel.phone)
            .sink { _ in
                // handle error
            } receiveValue: { [weak self] response in
                guard let self else { return }
                print(response.otpCode)
                self.configModel = AuthOtpConfigModel(
                    otpId: response.otpId,
                    phone: self.configModel.phone,
                    otpCode: response.otpCode,
                    otpLength: response.otpLen)
            }
            .store(in: &cancellables)
    }

    private func confirmOtp() {
        authRequestManager.authConfirm(otpId: configModel.otpId,
                                       phone: configModel.phone,
                                       otpCode: configModel.otpCode)
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
