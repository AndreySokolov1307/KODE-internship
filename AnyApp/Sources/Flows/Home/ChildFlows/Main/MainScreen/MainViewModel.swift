// swiftlint:disable all
import Services
import Combine
import UI
import Core

final class MainViewModel {

    typealias Props = MainViewProps

    enum Output {
        case content(Props)
        case accountDetail(AccountDetailConfigModel)
        case cardDetail(CardDetailConfigModel)
        case error(ErrorView.Props)
        case errorMessage(String)
    }

    enum Input {
        case loadData
        case refreshData
    }
    
    private let coreRequestManager: CoreRequestManagerAbstract
    
    private var obtainedData = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(coreRequestManager: CoreRequestManagerAbstract) {
        self.coreRequestManager = coreRequestManager
    }
    
    var onOutput: ((Output) -> Void)?

    func handle(_ input: Input) {
        switch input {
        case .loadData:
            sendShimmerSections()
            loadData()
        case .refreshData:
            loadData()
        }
    }
        
    private func loadData() {
        coreRequestManager.coreAccountList()
            .combineLatest(coreRequestManager.coreDepositList())
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
            } receiveValue: { [weak self] (accountListResponce, depositListResponce) in
                guard let self else { return }
            
                let accountSection = self.createAccountSection(accountListResponce.accounts)
                let depositSection = self.createDepositSection(depositListResponce.deposits)
                    
                self.obtainedData = true
                
                self.onOutput?(.content(.init(sections: [accountSection, depositSection])))
            }
            .store(in: &cancellables)
    }
    
    private func sendError(with props: ErrorView.Props) {
        onOutput?(.error(props))
    }
    
    private func createAccountSection(_ accounts: [Account]) -> Props.Section {
        var accountItems: [MainViewProps.Item] = [.header(.init(title: Main.accounts))]
        
        accounts.forEach { account in
            let item = MainViewProps.Item.account(
                .init(id: account.accountId,
                      balance: account.balance,
                      currency: account.currency,
                      onTap: { [weak self] in
                          let configModel = AccountDetailConfigModel(id: account.accountId)
                          self?.onOutput?(.accountDetail(configModel))
                      }))
            accountItems.append(item)
            
            account.cards.forEach { card in
                let item = MainViewProps.Item.card(
                    .init(id: card.cardId,
                          name: card.name,
                          cardType: card.cardType,
                          status: card.status,
                          cardNumber: card.number,
                          paymentSystem: card.paymentSystem,
                          onTap: { [weak self] in
                              let configModel = CardDetailConfigModel(cardId: card.cardId)
                              self?.onOutput?(.cardDetail(configModel))
                          }))
                accountItems.append(item)
            }
        
            accountItems += MainViewModel.mockCards
        }
        
        return MainViewProps.Section.accounts(accountItems)
    }

    private func createDepositSection(_ deposits: [Deposit]) -> Props.Section {
        var depositItems: [MainViewProps.Item] = [.header(.init(title: Main.deposits))]
        
        deposits.forEach { deposit in
            let item = MainViewProps.Item.deposit(
                .init(id: deposit.depositId,
                      name: deposit.name,
                      status: deposit.status,
                      currency: deposit.currency,
                      balance: deposit.balance,
                      interestRate: 7.45,
                      closingDate: Date(),
                      onTap: {
                          SnackCenter.shared.showInDevelopmentSnack()
                      }))
            depositItems.append(item)
        }
        depositItems += MainViewModel.mockDeposits
        
        return MainViewProps.Section.deposits(depositItems)
    }
    
    private func sendShimmerSections() {
        onOutput?(.content(.init(sections: [
            .accounts(
                [.headerShimmer()] +
                (1...3).map { _ in .accountShimmer() }
            ),
            .deposits(
                [.headerShimmer()] +
                (1...3).map { _ in .accountShimmer() }
            )
        ])))
    }
}

extension MainViewModel {
    static let mockCards: [MainViewProps.Item] = [
        .card(.init(id: "1234",
                    name: "Дополнительная карта",
                    cardType: .digital,
                    status: .deactivated,
                    cardNumber: "88005553535",
                    paymentSystem: .masterCard,
                    onTap: {
                        SnackCenter.shared.showInDevelopmentSnack()
                    }))
        ]
    
    static let mockDeposits: [MainViewProps.Item] = [
    .deposit(.init(id: 555,
                   name: "Накопительный",
                   status: .active,
                   currency: .usd,
                   balance: 3719,
                   interestRate: 8.75,
                   closingDate: Date(),
                   onTap: {
                       SnackCenter.shared.showInDevelopmentSnack()
                   })),
    .deposit(.init(id: 777,
                   name: "EUR вклад",
                   status: .active,
                   currency: .eur,
                   balance: 1567,
                   interestRate: 5.76,
                   closingDate: Date(),
                   onTap: {
                       SnackCenter.shared.showInDevelopmentSnack()
                   }))
   ]
}
