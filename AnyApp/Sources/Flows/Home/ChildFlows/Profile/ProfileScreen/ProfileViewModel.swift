import Services
import Combine
import UI
import UIKit
// swiftlint:disable: all
final class ProfileViewModel {
    typealias Props = ProfileViewProps
    
    enum Output {
        case content(Props)
        case about
        case theme
        case logOut
        case error(ErrorView.Props)
        case errorMessage(String)
    }

    enum Input {
        case logout
        case loadData
        case refreshData
    }
    
    // MARK: - Public Properties
    
    var onOutput: ((Output) -> Void)?
    
    // MARK: - Private Properties

    private let appSession: AppSession
    
    private var obtainedData = false
    
    private let coreRequestManager: CoreRequestManagerAbstract

    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - ProfileViewModel

    init(
        appSession: AppSession,
        coreRequestManager: CoreRequestManagerAbstract
    ) {
        self.appSession = appSession
        self.coreRequestManager = coreRequestManager
    }

    // MARK: - Public Methods
    
    func handle(_ input: Input) {
        switch input {
        case .logout:
            appSession.handle(.logout(.init(needFlush: true, alert: .snack(message: Common.logOut))))
        case .loadData:
            sendShimmerSections()
            loadData()
        case .refreshData:
            loadData()
        }
    }
    
    // MARK: - Private Methods
    
    private func createSettingsSection() -> Props.Section {
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
                    self?.callSupport()
                }))
        let logOutItem: Props.Item = .info(
            .init(
                title: Profile.logOut,
                image: Asset.Images.quit.image,
                onTap: { [weak self] in
                    self?.onOutput?(.logOut)
                }))
        let settings: Props.Section = .settings([aboutItem, themeItem, supportItem, logOutItem])
        
        return settings
    }
    
    private func sendShimmerSections() {
        onOutput?(.content(.init(sections: [
            .profile(.profileShimmer()),
            .settings(
                (1...4).map { _ in .infoShimmer() }
            )
        ])))
    }

    private func loadData() {
        coreRequestManager.coreProfile()
            .sink { [weak self] completion in
                guard let self else { return }
                
                switch completion {
                case .failure(let error):
                    if self.obtainedData {
                        let message = ErrorHandler.getMessage(for: error.appError)
                        self.onOutput?(.errorMessage(message))
                    } else {
                        let props = ErrorHandler.getProps(for: error.appError) {
                            self.sendShimmerSections()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.loadData()
                            }
                        }
                        self.sendError(with: props)
                    }
                case .finished:
                    break
                }
            } receiveValue: { [weak self] responce in
                guard let self else { return }
                
                self.obtainedData = true
                
                let profileSection = self.createProfileSection(with: responce)
                let settingsSection = self.createSettingsSection()
                
                self.onOutput?(.content(.init(sections: [ profileSection, settingsSection])))
            }
            .store(in: &cancellables)
    }
    
    private func createProfileSection(with responce: CoreProfileResponse) -> Props.Section {
        return .profile(.profile(.init(
            avatarImage: Asset.Images.avatarStub.image,
            name: responce.fullName,
            phoneNumber: responce.phone)))
    }
    
    private func sendError(with props: ErrorView.Props) {
        onOutput?(.error(props))
    }
    
    private func callSupport() {
        guard let url = URL(string: Profile.supportPhoneNumber),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
