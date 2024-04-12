import Services
import UI
import Combine

final class AuthPhoneViewModel {

    enum Output {
        case otp
        case invalidNumber
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
                login(phoneNumber: number)
            } else {
                onOutput?(.invalidNumber)
            }
        }
    }

    private func login(phoneNumber: String) {
        authRequestManager.authLogin(phone: phoneNumber)
            .sink(
                receiveCompletion: { _ in
                    // TODO: handle error
                },
                receiveValue: { [weak self] response in
                    self?.onOutput?(.otp)
                }
            ).store(in: &cancellables)
    }
    
    private func isNumberValid(_ number: String) -> Bool {
        let phonePattern = #"^[\+]\d{1}[ ]?\(?\d{3}\)?[ ]?\d{3}[ ]?\d{2}[ ]?\d{2}$"#
        var result = number.range(of: phonePattern, options: .regularExpression)
        let isValid = (result != nil)
        return isValid
    }
}
