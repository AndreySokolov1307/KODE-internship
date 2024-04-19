import Services
import Combine

final class ProfileViewModel {
    typealias Props = ProfileViewProps
    
    enum Output {
        case content(Props)
        case about
        case theme
        case support
        case logOut
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
            .settings(
                (1...4).map { _ in .infoShimmer() }
            )
        ])))
        
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.onOutput?(.content(.init(sections: [
                .profile(.profile(.init(avatarImage: Asset.Images.avatarStub.image,
                                        name: "Филлип Ребийяр Олегович",
                                        phoneNumber: "+7 951 098 98 98 "))),
                .settings([
                    .info(.init(infoType: .about) { [weak self] in
                        self?.onOutput?(.about)
                    }),
                    .info(.init(infoType: .theme) { [weak self] in
                        self?.onOutput?(.theme)
                    }),
                    .info(.init(infoType: .support) { [weak self] in
                        self?.onOutput?(.support)
                    }),
                    .info(.init(infoType: .logOut) { [weak self] in
                        self?.onOutput?(.logOut)
                    })
                ])
            ])))
        }
    }
}
