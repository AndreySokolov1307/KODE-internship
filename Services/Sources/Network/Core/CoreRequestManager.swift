import Core
import Combine
import Alamofire

public protocol CoreRequestManagerAbstract: AnyObject {

    func coreProfile() -> AppPublisher<CoreProfileResponse>

    func coreAccountList() -> AppPublisher<CoreAccountListResponse>

    func coreDepositList() -> AppPublisher<CoreDepositListResponse>

    func coreAccount(id: Int) -> AppPublisher<CoreAccountResponse>

    func coreCard(id: String) -> AppPublisher<CoreCardResponse>
}

final class CoreRequestManager: NetworkRequestManager, CoreRequestManagerAbstract {

    func coreProfile() -> AppPublisher<CoreProfileResponse> {
       return request(
            path: CorePath.profile,
            pathParams: ["version": "6096726"]
        )
    }

    func coreAccountList() -> AppPublisher<CoreAccountListResponse> {
        request(
            path: CorePath.accountList,
            pathParams: ["version": "6096726"]
        )
    }

    func coreDepositList() -> AppPublisher<CoreDepositListResponse> {
        request(
            path: CorePath.depositList,
            pathParams: ["version": "6096726"]
        )
    }

    func coreAccount(id: Int) -> AppPublisher<CoreAccountResponse> {
        request(
            path: CorePath.account,
            pathParams: [
                "accountId": id,
                "version": "6096726"
            ]
        )
    }

    func coreCard(id: String) -> Core.AppPublisher<CoreCardResponse> {
        request(
            path: CorePath.card,
            pathParams: [
                "cardId": id,
                "version": "6096726"
            ]
        )
    }
}
