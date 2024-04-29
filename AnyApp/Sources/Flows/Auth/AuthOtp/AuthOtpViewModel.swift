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
        case error(String)
        case loading
    }
    
    // MARK: - Public Properties
    
    var onOutput: ((Output) -> Void)?
    
    // MARK: - Private Properties
    
    private var otpAttemptsLeft = 5

    private var configModel: ConfigModel
    private let authRequestManager: AuthRequestManagerAbstract
    private let appSession: AppSession
    
    private var otpAttemptsLeftMessage: String {
        let attemptString = Plurals.attemptsLeft(otpAttemptsLeft)
        let leftString = Plurals.leftFem(otpAttemptsLeft)
        return ("Неверный код. \(leftString) \(otpAttemptsLeft) " + attemptString)
    }

    private var cancellables = Set<AnyCancellable>()

    // MARK: - AuthOtpViewModel
    
    init(
        configModel: AuthOtpConfigModel,
        authRequestManager: AuthRequestManagerAbstract,
        appSession: AppSession
    ) {
        self.configModel = configModel
        self.authRequestManager = authRequestManager
        self.appSession = appSession
    }
    
    // MARK: - Public Methods
    
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
    
    // MARK: - Private Methods
    
    private func isOtpValid(_ otp: String) -> Bool {
        return otp == configModel.otpCode
    }
    
    private func otpRepeat() {
        authRequestManager.authLogin(phone: configModel.phone)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    let message = ErrorHandler.getMessage(for: error.appError)
                    self?.onOutput?(.error(message))
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                
                self.configModel = AuthOtpConfigModel(
                    otpId: response.otpId,
                    phone: self.configModel.phone,
                    otpCode: response.otpCode,
                    otpLength: response.otpLen)
            }
            .store(in: &cancellables)
    }
    
    private func confirmOtp() {
        sendLoading()
        
        authRequestManager.authConfirm(
            otpId: configModel.otpId,
            phone: configModel.phone,
            otpCode: configModel.otpCode)
        .sink(
            receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    let message = ErrorHandler.getMessage(for: error.appError)
                    self?.onOutput?(.error(message))
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.appSession.handle(.updateTokens(
                    accessToken: response.guestToken,
                    refreshToken: ""
                ))
                self?.onOutput?(.userLoggedIn)
            }
        ).store(in: &cancellables)
    }
    
    private func sendLoading() {
        onOutput?(.loading)
    }
}
