import Foundation
import Core

// swiftlint:disable final_class
public protocol SessionAbstract: AnyObject {
    /// Current Session Status
    var state: AppSession.State { get }

    /// Event Processing Subscription
    var event: AppSession.Event { get }

    /// Is the session active
    ///
    /// - true: Active, the user uses the application at the given moment
    /// - false: Inactive, the user minimized the application
    /// Handling events through which the state is modified
    func handle(_ action: AppSession.Action)

    var isLoggedIn: Bool { get }
}
