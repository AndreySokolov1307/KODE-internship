import Services
import Combine
import UI

final class AccountDetailViewModel {
    
    typealias Props = AccountDetailViewProps
    typealias ConfigModel = AccountDetailConfigModel
    
    enum Output {
        case content(Props)
    }
    
    enum Input {
        case refresh
        case loadData
    }
    
    // MARK: - Private Properties
    
    private let coreRequestManager: CoreRequestManagerAbstract

    private var cancellables = Set<AnyCancellable>()
    
    private let configModel: ConfigModel
    
    private var selectedTab = InfoTabView.Props.TabsType.transactions
    
    private var mainInfoSection: Props.Section?
    private var infoTabSection: Props.Section?
    private var bottomSection = AccountDetailViewModel.mockTransactionSection
    private let paymentSection: Props.Section = .list([
        .payment(.init(
            title: Main.AccountDetail.cellular,
            image: Asset.Images.phoneWithCircle.image)),
        .payment(.init(
            title: Main.AccountDetail.jkh,
            image: Asset.Images.jkh.image)),
        .payment(.init(
            title: Main.AccountDetail.internet,
            image: Asset.Images.internet.image))
    ])
    private let actionSection: Props.Section = .list([
        .action(.init(
            title: Main.AccountDetail.linkedCards,
            image: Asset.Images.card.image,
            hasAccessory: true,
            accessoryType: .down)),
        .action(.init(
            title: Main.AccountDetail.renameAccount,
            image: Asset.Images.edit.image)),
        .action(.init(
            title: Main.AccountDetail.requisites,
            image: Asset.Images.requisites.image)),
        .action(.init(
            title: Main.AccountDetail.closeAccount,
            image: Asset.Images.list.image))
    ])
    
    // MARK: - Public Properties
    
    var onOutput: ((Output) -> Void)?
    
    init(configModel: ConfigModel,
         coreRequestManager: CoreRequestManagerAbstract) {
        self.configModel = configModel
        self.coreRequestManager = coreRequestManager
    }
    
    // MARK: - Public methods

    public func handle(_ input: Input) {
        switch input {
        case .loadData:
            sendShimmerSections()
            loadData()
        case .refresh:
            loadData()
        }
    }
    
    // MARK: - Private methods

    private func loadData() {
        coreRequestManager.coreAccount(id: configModel.id)
            .sink { completion in
                //TODO: - handle error
            } receiveValue: { [weak self] accountResponse in
                guard let self else { return }
    
                self.mainInfoSection = self.createMainInfoSection(with: accountResponse)
                self.infoTabSection = self.createInfoTabSection()
                self.sendSections()
            }
            .store(in: &cancellables)
    }
    
    private func sendSections() {
        if let mainInfoSection, let infoTabSection {
            onOutput?(.content(.init(
                sections: [
                    mainInfoSection,
                    infoTabSection,
                    bottomSection
                ])))
        }
    }
    
    private func sendShimmerSections() {
        onOutput?(.content(.init(sections: [
            .mainInfo(
                .accountInfoShimmer()
            ),
            .infoTab(
                .infoTabShimmer()
            ),
            .list(
                [.headerShimmer()] +
                (1...3).map { _ in .transactionShimmer() }
            )
        ])))
    }
    
    private func createMainInfoSection(with accountResponce: CoreAccountResponse)
    -> Props.Section {
        return .mainInfo(.accountInfo(.init(
            currency: accountResponce.currency,
            balance: accountResponce.balance,
            accountNumber: accountResponce.number)))
    }
    
    private func createInfoTabSection() -> Props.Section {
        return .infoTab(.tab(.init(
            selectedTab: selectedTab,
            onTransaction: { [weak self] in
                self?.selectedTab = .transactions
                self?.bottomSection = AccountDetailViewModel.mockTransactionSection
                self?.sendSections()
            },
            onAction: { [weak self] in
                guard let self else { return }
                self.selectedTab = .actions
                self.bottomSection = self.actionSection
                self.sendSections()
            },
            onPayment: { [weak self] in
                guard let self else { return }
                self.selectedTab = .payments
                self.bottomSection = self.paymentSection
                self.sendSections()
            })))
    }
}

extension AccountDetailViewModel {
    static let mockTransactionSection = Props.Section.list([
        .header(.init(
            // TODO: - get current month and create props for header with formatted date
            title: "Июнь 2021")),
        .transaction(.init(
            type: .payment,
            balance: Main.AccountDetail.mockBalance1,
            info: Main.AccountDetail.mockInfo1,
            date: Date() )),
        .transaction(.init(
            type: .payment,
            balance: Main.AccountDetail.mockBalance2,
            info: Main.AccountDetail.mockInfo2,
            date: Date())),
        .transaction(.init(
            type: .transfer,
            balance: Main.AccountDetail.mockBalance3,
            info: Main.AccountDetail.mockInfo3,
            date: Date()))
    ])
}
