import LocalAuthentication
import Core

public protocol QuickAccessAbstract {
    var state: QuickAccess.State { get }
    func handle(_ action: QuickAccess.Action)
    var needAskPermission: Bool { get }
}

// swiftlint:disable cyclomatic_complexity
public final class QuickAccess: QuickAccessAbstract {

    // MARK: - Properties

    let sessionStorage: SessionStorage
    var context: LAContext = {
        let context = LAContext()
        context.localizedFallbackTitle = ""

        return context
    }()
    var error: NSError?

    // MARK: - State

    public enum State {
        case disabled
        case enabled(includingBiometry: Bool)
    }

    @Published public var state: State = .disabled

    init(sessionStorage: SessionStorage) {
        self.sessionStorage = sessionStorage
        updateState()
    }

    private func updateState() {
        if sessionStorage.pin == nil || sessionStorage.refreshToken == nil {
            state = .disabled
        } else {
            state = .enabled(includingBiometry: sessionStorage.isBiometryUsed == true)
        }
    }

    // MARK: - Biometry Support

    public enum BiometrySupport {
        case touchID
        case faceID
        case none

        var name: String {
            switch self {
            case .faceID:
                return "Face ID"
            case .touchID:
                return "Touch ID"
            case .none:
                return ""
            }
        }
    }

    // MARK: - Actions

    public enum Action {
        case isBiometrySupportedByDevice(BiometrySupportedByDeviceResult)
        case isBiometryAllowedForUse(BiometryAllowedForUseResult)
        case biometrySupportedByDevice(BiometrySupportedByDeviceCompletion)
        case getRefreshTokenByPin(String, GetRefreshTokenByPinCompletion)
        case updatePinInStorage(String)
        case logout
        case remakeContext
        case activateBiometry(ActivateBiometryCompletion)
        case deactivateBiometry
        case getPinByBiometry(GetPinByBiometryCompletion)
        case checkPin(String, CheckPinCompletion)
        case saveCurrentBiometryDomainState
        case isBiometryUsed(BiometryUsedCompletion)
        case getBiometryName(BiometryNameCompletion)
        case getBiometryType(BiometryTypeCompletion)
    }

    public func handle(_ action: Action) {
        switch action {
        case .isBiometrySupportedByDevice(let callback):
            handleIsBiometrySupportedByDevice(callback)
        case .isBiometryAllowedForUse(let callback):
            handleIsBiometryAllowedForUse(callback)
        case .biometrySupportedByDevice(let callback):
            handleBiometrySupportedByDevice(callback)
        case .getRefreshTokenByPin(let pin, let callback):
            handleGetRefreshToken(by: pin, callback)
        case .updatePinInStorage(let pin):
            handleUpdatePinInStorage(pin)
        case .logout:
            reset()
        case .remakeContext:
            remakeContext()
        case .activateBiometry(let callback):
            handleActivateBiometry(callback)
        case .deactivateBiometry:
            handleDeactivateBiometry()
        case .getPinByBiometry(let callback):
            handleGetPinByBiometry(callback)
        case let .checkPin(pin, callback):
            handleCheckPin(pin, callback)
        case .saveCurrentBiometryDomainState:
            handleSaveCurrentBiometryDomainState()
        case .isBiometryUsed(let callback):
            handleIsBiometryUsed(callback)
        case .getBiometryName(let callback):
            handleGetBiometryName(callback)
        case .getBiometryType(let callback):
            handleGetBiometryType(callback)
        }
        updateState()
    }

    /// Does the device support biometrics
    public typealias BiometrySupportedByDeviceResult = (Bool) -> Void
    func handleIsBiometrySupportedByDevice(_ callback: BiometrySupportedByDeviceResult) {
        callback(biometrySupported == .touchID || biometrySupported == .faceID)
    }

    /// Does the user use biometrics to log in to the device
    public typealias BiometryAllowedForUseResult = (_ result: Bool, _ message: String) -> Void
    func handleIsBiometryAllowedForUse(_ callback: BiometryAllowedForUseResult) {
        // TODO: Fix
        // let _ = biometrySupported.name
        if case .enabled(includingBiometry: true) = state, biometrySupported != .none {
            guard let oldDomainState: Data = sessionStorage.biometryDomainState else {
                callback(true, "")
                return
            }
            if context.evaluatedPolicyDomainState == oldDomainState {
                callback(true, "")
            } else {
                callback(false, "")
            }
        } else {
            callback(false, "")
        }
    }

    /// Type of biometrics on the device
    public typealias BiometrySupportedByDeviceCompletion = (BiometrySupport) -> Void
    func handleBiometrySupportedByDevice(_ callback: BiometrySupportedByDeviceCompletion) {
        callback(biometrySupported)
    }

    public typealias GetRefreshTokenByPinCompletion = (String?) -> Void

    /// Getting RefreshToken for PIN authorization
    func handleGetRefreshToken(by pin: String, _ callback: GetRefreshTokenByPinCompletion) {
        guard
            let savedPin: String = sessionStorage.pin,
            pin == savedPin,
            let refreshToken: String = sessionStorage.refreshToken
        else {
            return callback(nil)
        }
        callback(refreshToken)
    }

    /// PIN update in storage
    /// - Parameter pin: PIN
    func handleUpdatePinInStorage(_ pin: String) {
        sessionStorage.pin = pin
    }

    /// LAContext update for biometrics reauthentication
    func reset() {
        context = LAContext()
        context.localizedFallbackTitle = ""
    }

    func remakeContext() {
        context = LAContext()
    }

    /// Enabling the use of biometrics on the device
    public typealias ActivateBiometryCompletion = (Bool, Error?, String) -> Void
    func handleActivateBiometry(_ callback: @escaping ActivateBiometryCompletion) {
        let biometryName = biometrySupported.name
        requestBiometryAuthentication { [weak self] result in
            switch result {
            case .success:
                self?.sessionStorage.isBiometryUsed = true
                self?.handleSaveCurrentBiometryDomainState()
                self?.updateState()
                callback(true, nil, biometryName)
            case .failure(let error):
                callback(false, error, biometryName)
            }
        }
    }

    /// Disabling the use of biometrics on the device
    func handleDeactivateBiometry() {
        sessionStorage.isBiometryUsed = false
    }

    /// Obtaining PIN through biometric authorization
    public typealias GetPinByBiometryCompletion = (String?, Error?) -> Void
    func handleGetPinByBiometry(_ callback: @escaping GetPinByBiometryCompletion) {
        requestBiometryAuthentication { [weak self] result in
            switch result {
            case .success:
                callback(self?.sessionStorage.pin, nil)
            case .failure(let error):
                callback(nil, error)
            }
        }
    }

    /// Verification of the entered PIN with stored in the store
    public typealias CheckPinCompletion = (Bool) -> Void
    func handleCheckPin(_ pin: String, _ callback: @escaping CheckPinCompletion) {
        callback(sessionStorage.pin == pin)
    }

    /// Saving user biometric data
    func handleSaveCurrentBiometryDomainState() {
        sessionStorage.biometryDomainState = context.evaluatedPolicyDomainState
    }

    /// Does the user use biometrics to log in to the app
    public typealias BiometryUsedCompletion = (Bool) -> Void
    func handleIsBiometryUsed(_ callback: @escaping BiometryUsedCompletion) {
        callback(sessionStorage.isBiometryUsed ?? false)
    }

    public typealias BiometryNameCompletion = (String) -> Void
    func handleGetBiometryName(_ callback: @escaping BiometryNameCompletion) {
        #if TARGET_IPHONE_SIMULATOR
        callback("Simulator ID")
        #else
        callback(biometrySupported.name)
        #endif
    }

    public typealias BiometryTypeCompletion = (BiometrySupport) -> Void
    func handleGetBiometryType(_ callback: @escaping BiometryTypeCompletion) {
        #if TARGET_OS_SIMULATOR
        callback(.touchID)
        #else
        callback(biometrySupported)
        #endif
    }

    public var needAskPermission: Bool {
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            switch context.biometryType {
            case .faceID, .touchID:
                return biometrySupported != .none
            default:
                return false
            }
        } else {
            return false
        }
    }
}

// MARK: - Helpers

fileprivate
extension QuickAccess {

    func requestBiometryAuthentication(callback: @escaping (Result<Bool, Error>) -> Void) {
        if context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        ) {

            var reason = ""
            switch biometrySupported {
            case .faceID:
                reason = "faceID"
            case .touchID:
                reason = "touchID"
            default:
                break
            }

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { _, error in
                if let error = error {
                    callback(.failure(error))
                } else {
                    callback(.success(true))
                }
            }
        } else {
            if let error = error {
                callback(.failure(error))
            }
        }
    }

    var biometrySupported: BiometrySupport {
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            switch context.biometryType {
            case .faceID:
                return .faceID
            case .touchID:
                return .touchID
            default:
                return .none
            }
        } else {
            return .none
        }
    }
}
