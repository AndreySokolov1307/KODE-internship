//
//  CoreAccountResponce.swift
//  Services
//
//  Created by Андрей Соколов on 23.04.2024.
//

import Foundation

public struct CoreAccountResponse: Decodable {

    public enum Status: String, Decodable {
        case active = "Активен"
    }

    public enum Currency: String, Decodable {
        case rub = "RUB"
    }

    public let number: String
    public let status: Status
    public let balance: Int
    public let currency: Currency
    public let accountId: Int
}
