import Services
import Combine

final class ProfileViewModel {
    typealias Props = ProfileViewProps
    
    enum Output {
        case content(Props)
    }

    enum Input {
        case logout
        case loadProfile
    }
    
    var onOutput: ((Output) -> Void)?

    private let appSession: AppSession

    private var cancellables = Set<AnyCancellable>()

    init(
        appSession: AppSession
    ) {
        self.appSession = appSession
    }

    func handle(_ input: Input) {
        switch input {
        case .logout:
            appSession.handle(.logout(.init(needFlush: true, alert: .snack(message: "Вы разлогинились"))))
        case .loadProfile:
            loadProfile()
        }
    }
    
    private func loadProfile() {
        onOutput?(.content(.init(sections: [
            .profile(.profileShimmer()),
            .info(
                (1...4).map { _ in .infoShimmer() }
            )
        ])))
    }
}
