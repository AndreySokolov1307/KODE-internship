import Services
import Combine

final class AuthPhoneViewModel {

    enum Output {
        case otp
    }

    enum Input {
        case phoneEntered
    }

    var onOutput: ((Output) -> Void)?

    private let authRequestManager: AuthRequestManagerAbstract

    private var cancellables = Set<AnyCancellable>()

    init(authRequestManager: AuthRequestManagerAbstract) {
        self.authRequestManager = authRequestManager
    }

    func handle(_ input: Input) {
        switch input {
        case .phoneEntered:
            login()
        }
    }

    private func login() {
        authRequestManager.authLogin(phone: "")
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
