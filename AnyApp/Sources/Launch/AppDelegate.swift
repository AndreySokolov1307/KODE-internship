import UI
import Core
import UIKit
import Swinject
import SwinjectAutoregistration
import AppIndependent
import Services
import Firebase

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var libraryManager = LibraryManager()

    private lazy var servicesFactory = DIContainer.shared.resolver ~> ServicesFactory.self
    private lazy var serviceLayer = DIContainer.shared.resolver ~> ServiceLayer.self
    private lazy var pushNotificationService: PushNotificationServiceAbstract = servicesFactory
        .makePushNotificationService(
            application: UIApplication.shared,
            persistent: serviceLayer.persistent
        )

    private var appCoordinator: AppCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        libraryManager.setupAllLibrary()

        setupPushes()

        return true
    }

    func setupPushes() {
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        UIApplication.shared.registerForRemoteNotifications()
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Logger().error("Fail To Register For Remote Notifications")
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        let tokenParts = deviceToken.map { data -> String in
            String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()

        serviceLayer.persistent.set(.apnsToken(token))

        Messaging.messaging().apnsToken = deviceToken as Data

        Logger().info("APNS Token received: \(token)")
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(#function)
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        let options = pushNotificationService.handlePresentNotification(payload: userInfo)
        completionHandler(options)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        _ = pushNotificationService.handleTapNotification(payload: userInfo)
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        Logger().info("FCM Token received: \(fcmToken ?? "-")")
    }
}
