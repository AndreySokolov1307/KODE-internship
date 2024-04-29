import Services
import Combine
import UI

final class CardDetailViewModel {
    
    typealias Props = CardDetailViewProps
    typealias ConfigModel = CardDetailConfigModel
    
    enum Output {
        case content(Props)
        case error(ErrorView.Props)
        case errorMessage(String)
    }
    
    enum Input {
        case loadData
        case refreshData
    }
    
    // MARK: - Public Properties
    
    var onOutput: ((Output) -> Void)?
    
    // MARK: - Private Properties
    
    private let configModel: ConfigModel
    
    private var obtainedData = false
    
    private let coreRequestManager: CoreRequestManagerAbstract

    private var cancellables = Set<AnyCancellable>()
    
    private var selectedTab = InfoTabView.Props.TabsType.transactions
    
    private var cardInfoSection: Props.Section?
    private var infoTabSection: Props.Section?
    private var bottomSection = CardDetailViewModel.mockTransactionSection
    private let actionSection: Props.Section = .list([
        .action(.init(title: Main.CardDetail.rename,
                      image: Asset.Images.edit.image)),
        .action(.init(title: Main.CardDetail.requisites,
                      image: Asset.Images.requisites.image)),
        .action(.init(title: Main.CardDetail.info,
                      image: Asset.Images.card.image)),
        .action(.init(title: Main.CardDetail.issue,
                      image: Asset.Images.cardOut.image)),
        .action(.init(title: Main.CardDetail.block,
                      image: Asset.Images.lock.image))
    ])
    private let paymentSection: Props.Section = .list([
        .payment(.init(title: Main.CardDetail.cellular,
                       image: Asset.Images.phoneWithCircle.image)),
        .payment(.init(title: Main.CardDetail.jkh,
                       image: Asset.Images.jkh.image)),
        .payment(.init(title: Main.CardDetail.internet,
                       image: Asset.Images.internet.image))
    ])
    
    // MARK: - CardDetailViewModel
    
    init(configModel: ConfigModel,
         coreRequestManager: CoreRequestManagerAbstract) {
        self.configModel = configModel
        self.coreRequestManager = coreRequestManager
    }

    // MARK: - Public methods
    
    func handle(_ input: Input) {
        switch input {
        case .loadData:
            sendShimmerSections()
            loadData()
        case .refreshData:
            loadData()
        }
    }
    
    // MARK: - Private methods
    
    private func loadData() {
        coreRequestManager.coreCard(id: configModel.cardId)
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
            } receiveValue: { [weak self] cardResponse in
                guard let self else { return }
    
                self.cardInfoSection = self.createCardInfoSection(with: cardResponse)
                self.infoTabSection = self.createInfoTabSection()
                
                self.obtainedData = true
                
                self.sendSections()
            }
            .store(in: &cancellables)
    }
    
    private func sendSections() {
        if let cardInfoSection, let infoTabSection {
            onOutput?(.content(.init(
                sections: [
                    cardInfoSection,
                    infoTabSection,
                    bottomSection
                ])))
        }
    }
    
    private func sendError(with props: ErrorView.Props) {
        onOutput?(.error(props))
    }
    
    private func sendShimmerSections() {
        onOutput?(.content(.init(sections: [
            .card(
                .cardShimmer()
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
    
    private func createCardInfoSection(with cardResponce: CoreCardResponse)
    -> Props.Section {
        return .card(.card(.init(
            id: cardResponce.id,
            name: cardResponce.name,
            status: cardResponce.status,
            number: cardResponce.number,
            paymentSystem: cardResponce.paymentSystem,
            expiredAt: cardResponce.expiredAt)))
    }
    
    private func createInfoTabSection() -> Props.Section {
        return .infoTab(.tab(.init(
            selectedTab: selectedTab,
            onTransaction: { [weak self] in
                self?.selectedTab = .transactions
                self?.bottomSection = CardDetailViewModel.mockTransactionSection
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

extension CardDetailViewModel {
    public static let mockTransactionSection: Props.Section = .list([
        .header(.init(
            title: Date().monthYearLongString)),
        .transaction(.init(
            type: .payment,
            transaction: -1500,
            info: Main.Mock.transaction1,
            date: Date() )),
        .transaction(.init(
            type: .payment,
            transaction: 15000,
            info: Main.Mock.transaction2,
            date: Date())),
        .transaction(.init(
            type: .transfer,
            transaction: -6000,
            info: Main.Mock.transaction3,
            date: Date()))
    ])
}
