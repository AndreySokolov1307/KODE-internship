import Services
import Combine

final class AuthPhoneViewModel {

    enum Output {
        case otp
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
            login(phoneNumber: number)
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
}
