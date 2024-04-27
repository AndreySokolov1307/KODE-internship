import Services
import Combine
// swiftlint:disable: all
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
        case loadData
        case refreshData
    }
    
    var onOutput: ((Output) -> Void)?

    private let appSession: AppSession
    
    private let coreRequestManager: CoreRequestManagerAbstract

    private var cancellables = Set<AnyCancellable>()

    init(
        appSession: AppSession,
        coreRequestManager: CoreRequestManagerAbstract
    ) {
        self.appSession = appSession
        self.coreRequestManager = coreRequestManager
    }

    func handle(_ input: Input) {
        switch input {
        case .logout:
            appSession.handle(.logout(.init(needFlush: true, alert: .snack(message: "Вы разлогинились"))))
        case .loadData:
            sendShimmer()
            loadData()
        case .refreshData:
            loadData()
        }
    }
    
    private func createSettings() -> [Props.Item] {
        let aboutItem: Props.Item = .info(
            .init(title: Profile.about,
                  image: Asset.Images.settings.image,
                  hasAccessory: true,
                  onTap: { [weak self] in
                      self?.onOutput?(.about)
                  }))
        let themeItem: Props.Item = .info(
            .init(
                title: Profile.theme,
                image: Asset.Images.moon.image,
                hasAccessory: true ,
                onTap: { [weak self] in
                    self?.onOutput?(.theme)
                }))
        let supportItem: Props.Item = .info(
            .init(
                title: Profile.support,
                image: Asset.Images.phoneCall.image,
                onTap: { [weak self] in
                    self?.onOutput?(.support)
                }))
        let logOutItem: Props.Item = .info(
            .init(
                title: Profile.logOut,
                image: Asset.Images.quit.image,
                onTap: { [weak self] in
                    self?.onOutput?(.logOut)
                }))
        let settings: [Props.Item] = [aboutItem, themeItem, supportItem, logOutItem]
        
        return settings
    }
    
    private func sendShimmer() {
        onOutput?(.content(.init(sections: [
            .profile(.profileShimmer()),
            .settings(
                (1...4).map { _ in .infoShimmer() }
            )
        ])))
    }

    private func loadData() {
        coreRequestManager.coreProfile()
            .sink { completion in
                
            } receiveValue: { [weak self] responce in
                guard let self else { return }
                self.onOutput?(.content(.init(sections: [
                    .profile(.profile(.init(avatarImage: Asset.Images.avatarStub.image,
                                            name: responce.fullName,
                                            phoneNumber: responce.phone))),
                    .settings(self.createSettings())
                ])))
            }
            .store(in: &cancellables)
    }
}
