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
    }
    
    // TODO: - прокинуть данные с Мейн контроллера или загрузить из сети хз
    enum Input {
        case accountData
    }
    
    var onOutput: ((Output) -> Void)?
    
    func handle(_ input: Input) {
        switch input {
        case .accountData:
            getData()
        }
    }
    
    private func getData() {
        onOutput?(.content(.init(sections: [
            .mainInfo(.accountInfo(.init(currency: .ruble, money: "457 334,00", accountNumber: "1234567812345666"))),
            .infoTab(.tab(.init(onRefresh: {
                print("refresh")
            }, onAction: {
                print("action")
            }, onPayment: {
                print("payment")
            }))),
            .transactions([
                .header(.init(title: "Июнь 2021")),
                .transaction(.init(type: .payment, money: "-1 500,00", info: "Оплата ООО ЯнтарьЭнерго", date: Date() )),
                .transaction(.init(type: .payment, money: "+15 000,00", info: "Зачисление зарплаты", date: Date())),
                .transaction(.init(type: .transfer, money: "-6 000,00", info: "Перевод Александру Олеговичу С vamo vamo vamo vamo vamo", date: Date()))
            ])
        ])))
        
        // request:
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
        //            self?.onOutput?()
        //    }
    }
}
