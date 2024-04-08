import Foundation
import Combine

public final class AppSession: SessionAbstract {

    @Published public var state: State // .initial
    @Published public var event: AppSession.Event = .none

    var bindings = Set<AnyCancellable>()

    public init(
        sessionStorage: SessionStorage,
        quickAccess: QuickAccessAbstract
    ) {
        self.storage = sessionStorage
        self.quickAccess = quickAccess
        self.state = State(
            quickAccess: quickAccess.state,
            tokens: State.Tokens(
                accessToken: storage.accessToken ?? "",
                refreshToken: storage.refreshToken ?? ""
            )
        )
    }

    public let storage: SessionStorage
    public let quickAccess: QuickAccessAbstract

    public var isLoggedIn: Bool {
        return !(storage.accessToken?.isEmpty ?? true)
    }
}
