import Services
import UI
import Combine

final class AuthPhoneViewModel {

    enum Output {
        case otp(AuthOtpConfigModel)
        case invalidNumber
        case sendRequest
    }

    enum Input {
        case phoneEntered(String)
    }

    var onOutput: ((Output) -> Void)?

    private let authRequestManager: AuthRequestManagerAbstract

    private var cancellables = Set<AnyCancellable>()

    init(authRequestManager: AuthRequestManagerAbstract) {
        self.authRequestManager = authRequestManager
    }

    func handle(_ input: Input) {
        switch input {
        case .phoneEntered(let number):
            if isNumberValid(number) {
                login(phone: number)
            } else {
                onOutput?(.invalidNumber)
            }
        }
    }

    private func login(phone: String) {
        onOutput?(.sendRequest)
        
        authRequestManager.authLogin(phone: phone)
            .sink(
                receiveCompletion: { completion in
                    
                },
                receiveValue: { [weak self] response in
                    let configModel = AuthOtpConfigModel(
                        otpId: response.otpId,
                        phone: phone,
                        otpCode: response.otpCode,
                        otpLength: response.otpLen
                    )
                    self?.onOutput?(.otp(configModel))
                }
            ).store(in: &cancellables)
    }
    
    private func isNumberValid(_ number: String) -> Bool {
        let phonePattern = #"^[\+]\d{1}[ ]?\(?\d{3}\)?[ ]?\d{3}[ ]?\d{2}[ ]?\d{2}$"#
        let result = number.range(of: phonePattern, options: .regularExpression)
        let isValid = (result != nil)
        return isValid
    }
}
