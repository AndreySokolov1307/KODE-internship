import Foundation
import UIKit

public final class ServiceLayer {

    public var environment: Environment

    public let session: AppSession

    public let persistent: Persistent

    public let network: Network

    let quickAccess: QuickAccessAbstract

    public init() {
        let persistent = PersistentLayer()
        environment = persistent.environment

        self.persistent = persistent

        if persistent.isFirstLaunch {
            persistent.sessionStorage.flush()
        }

        quickAccess = QuickAccess(sessionStorage: persistent.sessionStorage)

        session = AppSession(
            sessionStorage: persistent.sessionStorage,
            quickAccess: quickAccess
        )
        network = NetworkLayer(session: session, environment: environment)
    }

    func set(environment: Environment) {
        self.environment = environment
        network.set(environment: environment)
        persistent.set(.environment(environment))
    }
}
