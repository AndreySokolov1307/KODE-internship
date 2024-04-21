//
//  AccountDetailViewModel.swift
//  AnyApp
//
//  Created by Андрей Соколов on 17.04.2024.
//

import Services
import Combine
import UI

final class AccountDetailViewModel {
    
    typealias Props = AccountDetailViewProps
    
    enum Output {
        case content(Props)
        case section(Props.Section)
    }
    
    // TODO: - прокинуть данные с Мейн контроллера или загрузить из сети хз
    enum Input {
        case accountData
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
            .action(.init(title: "Привязаннык карты",
                          image: Asset.Images.card.image,
                          hasAccessory: true,
                          accessoryType: .down)),
            .action(.init(title: "Переименовать счет",
                          image: Asset.Images.edit.image)),
            .action(.init(title: "Реквизиты счета",
                          image: Asset.Images.requisites.image)),
            .action(.init(title: "Закрыть счет",
                          image: Asset.Images.list.image))
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
            .transaction(.init(type: .payment, money: "-1 500,00", info: "Оплата ООО ЯнтарьЭнерго", date: Date() )),
            .transaction(.init(type: .payment, money: "+15 000,00", info: "Зачисление зарплаты", date: Date())),
            .transaction(.init(type: .transfer, money: "-6 000,00", info: "Перевод Александру Олеговичу С vamo vamo vamo vamo vamo", date: Date()))
        ])
        
        return transactionList
    }
    
    // TODO: - rename and restructure after networkCall
    
    private func getSections(with input: Input) {
        let bottomSection: Props.Section
        switch input {
        case .accountData:
            bottomSection = createTransactionSection()
        case .actions:
            bottomSection = createActionSection()
        case .payments:
            bottomSection = createPaymentSection()
        }
        
        onOutput?(.content(.init(sections: [
            .mainInfo(.accountInfo(.init(currency: .ruble, money: "457 334,00", accountNumber: "1234567812345666"))),
            .infoTab(.tab(.init(onRefresh: { [weak self] in
                guard let self else { return }
                self.onOutput?(.section(self.createTransactionSection()))
            }, onAction: { [weak self] in
                guard let self else { return }
                self.onOutput?(.section(self.createActionSection()))
            }, onPayment: { [weak self] in
                guard let self else { return }
                self.onOutput?(.section(self.createPaymentSection()))
            }))),
                bottomSection
        ])))
        
        // request:
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
        //            self?.onOutput?()
        //    }
    }
}
