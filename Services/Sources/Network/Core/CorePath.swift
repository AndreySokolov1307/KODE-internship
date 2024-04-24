import Core

enum CorePath: Path, CaseIterable {
 
    case profile
    case accountList
    case depositList
    case account
    case card

    var id: String {
        switch self {
        case .profile:
            return "profile"
        case .accountList:
            return "accountList"
        case .depositList:
            return "depositList"
        case .account:
            return "account"
        case .card:
            return "card"
        }
    }

    public var endpoint: String {
        switch self {
        case .profile:
            return "core/profile"
        case .accountList:
            return "core/account/list"
        case .depositList:
            return "core/deposit/list"
        case .account:
            return "core/account/{accountId}"
        case .card:
            return "core/card/{cardId}"
        }
    }

    var method: HttpMethod { return .get }

    var requestContext: RequestContext {
        switch self {
        case .profile:
            return .core(.profile)
        case .accountList:
            return .core(.accountList)
        case .depositList:
            return .core(.depositList)
        case .card:
            return .core(.card)
        case .account:
            return .core(.account)
        }
    }
}
