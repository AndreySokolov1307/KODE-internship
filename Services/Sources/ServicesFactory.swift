import UIKit
import Core

public final class ServicesFactory {

    public init() {
    }

    public func makeServiceLayer() -> ServiceLayer {
        ServiceLayer()
    }

    public func makePushNotificationService(
        application: UIApplication,
        persistent: Persistent
    ) -> PushNotificationServiceAbstract {
        return PushNotificationServiceStub()
    }

    public func makePushNotificationService(application: UIApplication) -> PushNotificationServiceAbstract {
        PushNotificationServiceStub()
    }
}
