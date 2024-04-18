//
//  MainViewModel.swift
//  AnyApp
//
//  Created by Андрей Соколов on 12.04.2024.
//

import Services
import Combine
import UI

final class MainViewModel {

    typealias Props = MainViewProps

    enum Output {
        case content(Props)
        case accountDetail
    }

    enum Input {
        case loadData
    }

    var onOutput: ((Output) -> Void)?

    func handle(_ input: Input) {
        switch input {
        case .loadData:
            loadData()
        }
    }

    private func loadData() {
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

        // request:

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.onOutput?(.content(.init(sections: [
                .accounts([
                    .header(.init(title: Main.accounts)),
                    .account(.init(money: "457 334,00", currency: .ruble) { id in
                        self?.onOutput?(.accountDetail)
                    }),
                    .card(.init(cardType: .physical, cardPurpose: .salary, isBlocked: false, cardNumber: "20027789", paymentSystem: .masterCard) { id in
                        SnackCenter.shared.showSnack(withProps: .init(message: "Card pressed with \(id)"))
                    }),
                    .card(.init(cardType: .physical, cardPurpose: .extra, isBlocked: true, cardNumber: "20028435", paymentSystem: .visa) { id in
                        SnackCenter.shared.showSnack(withProps: .init(message: "Card pressed with \(id)"))
                    })
                ]),
                .deposits([
                    .header(.init(title: Main.deposits)),
                    .deposit(.init(type: .main, currency: .ruble, money: "1 515 000,78", interestRate: 7.65, dueDate: Date())),
                    .deposit(.init(type: .saving, currency: .dollar, money: "3 719,19", interestRate: 11.05, dueDate: Date())),
                    .deposit(.init(type: .currency(.euro), currency: .euro, money: "1 513,62", interestRate: 8.65, dueDate: Date()))
                ])
            ])))
        }
    }
}
