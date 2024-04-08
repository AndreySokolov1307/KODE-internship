import UserNotifications
import FirebaseMessaging
import AppIndependent
import Combine
import Core

public enum PushAction {

    public typealias RequestAuthCompletion = (Bool, Error?) -> Void
    public typealias CurrentStatusCompletion = (UNAuthorizationStatus) -> Void

    case requestAuth(_ completion: RequestAuthCompletion)
    case currentStatus(_ completion: CurrentStatusCompletion)
    case subscribe(_ completion: BoolHandler)
    case subscribeAndConfigure(_ completion: VoidHandler)
}

public protocol PushNotificationServiceAbstract {
    var fcmToken: String? { get }
    var pushToken: String? { get }

    func handle(_ action: PushAction)
    func sendUpdateTokens()
    func handleTapNotification(payload: [AnyHashable: Any]) -> UNNotificationPresentationOptions
    func handlePresentNotification(payload: [AnyHashable: Any]) -> UNNotificationPresentationOptions
    func didReceiveNotification(payload: [AnyHashable: Any])
    func handleSilentNotification(payload: [AnyHashable: Any])
}

final class PushNotificationServiceStub: PushNotificationServiceAbstract {

    var fcmToken: String?
    var pushToken: String?

    func handle(_ action: PushAction) {
    }

    func sendUpdateTokens() {
    }

    public func handlePresentNotification(payload: [AnyHashable: Any]) -> UNNotificationPresentationOptions {
        return [.badge, .sound]
    }

    public func handleTapNotification(payload: [AnyHashable: Any]) -> UNNotificationPresentationOptions {
        return [.badge, .sound]
    }

    public func didReceiveNotification(payload: [AnyHashable: Any]) {
        Messaging.messaging().appDidReceiveMessage(payload)
    }

    public func handleSilentNotification(payload: [AnyHashable: Any]) {
    }
}
