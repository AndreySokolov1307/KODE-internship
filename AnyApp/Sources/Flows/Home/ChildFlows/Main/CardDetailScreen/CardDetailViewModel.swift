//
//  CardDetailViewModel.swift
//  AnyApp
//
//  Created by Андрей Соколов on 21.04.2024.
//

import Services
import Combine
import UI

final class CardDetailViewModel {
    
    typealias Props = CardDetailViewProps
    
    enum Output {
        case content(Props)
    }
    
    enum Input {
        case transactions
        case actions
        case payments
    }
    
    var onOutput: ((Output) -> Void)?

    //TODO: - restructure after network request
    func handle(_ input: Input) {
        getSections(with: input)
    }
    
    private func createActionSection() -> Props.Section {
        let actionList: Props.Section = .list([
            .action(.init(title: "Переименовать карту",
                          image: Asset.Images.edit.image)),
            .action(.init(title: "Реквизиты счета",
                          image: Asset.Images.requisites.image)),
            .action(.init(title: "Информация о карте",
                          image: Asset.Images.card.image)),
            .action(.init(title: "Выпустить карту",
                          image: Asset.Images.cardOut.image)),
            .action(.init(title: "Заблокировать карту",
                          image: Asset.Images.lock.image))
        ])
        
        return actionList
    }
    
    private func createPaymentSection() -> Props.Section {
        let paymentList: Props.Section = .list([
            .payment(.init(title: "Мобильная связь",
                           image: Asset.Images.phoneWithCircle.image)),
            .payment(.init(title: "ЖКХ",
                           image: Asset.Images.jkh.image)),
            .payment(.init(title: "Интернет",
                           image: Asset.Images.internet.image))
        ])
        
        return paymentList
    }
    
    private func createTransactionSection() -> Props.Section {
        let transactionList: Props.Section = .list([
            .header(.init(title: "Июнь 2021")),
            .transaction(.init(type: .payment, balance: "-1 500,00", info: "Оплата ООО ЯнтарьЭнерго", date: Date() )),
            .transaction(.init(type: .payment, balance: "+15 000,00", info: "Зачисление зарплаты", date: Date())),
            .transaction(.init(type: .transfer, balance: "-6 000,00", info: "Перевод Александру Олеговичу С vamo vamo vamo vamo vamo", date: Date()))
        ])
        
        return transactionList
    }
    
    // TODO: - rename and restructure after networkCall
    
    private func getSections(with input: Input) {
        let bottomSection: Props.Section
        let selectedTap: InfoTabView.Props.TabsType
        switch input {
        case .transactions:
            bottomSection = createTransactionSection()
            selectedTap = .transactions
        case .actions:
            bottomSection = createActionSection()
            selectedTap = .actions
        case .payments:
            bottomSection = createPaymentSection()
            selectedTap = .payments
        }
        
        onOutput?(.content(.init(sections: [
            .card(.card(.init(cardType: .digital,
                              balance: "7 334,00",
                              isBlocked: false,
                              cardNumber: "9879879879",
                              paymentSystem: .visa,
                              closingDate: Date()))),
            .infoTab(.tab(.init(selectedTab: selectedTap, onTransaction: { [weak self] in
                guard let self else { return }
                self.handle(.transactions)
            }, onAction: { [weak self] in
                guard let self else { return }
                self.handle(.actions)
            }, onPayment: { [weak self] in
                guard let self else { return }
                self.handle(.payments)
            }))),
                bottomSection
        ])))
        
        // request:
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
        //            self?.onOutput?()
        //    }
    }
}
