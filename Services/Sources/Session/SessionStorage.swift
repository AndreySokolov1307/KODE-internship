import Foundation

public final class SessionStorage {

    let keychainStorage: KeychainStorage

    init(keychainStorage: KeychainStorage) {
        self.keychainStorage = keychainStorage
    }

    var accessToken: String? {
        get { return keychainStorage.load(byName: .accessToken) }
        set { keychainStorage.save(newValue, byName: .accessToken) }
    }

    var refreshToken: String? {
        get { return keychainStorage.load(byName: .refreshToken) }
        set { keychainStorage.save(newValue, byName: .refreshToken) }
    }

    var pin: String? {
        get { return keychainStorage.load(byName: .pin) }
        set { keychainStorage.save(newValue, byName: .pin) }
    }

    public var pinLoginAttemptsLeft: Int {
        get {
            if let attempts: Int = keychainStorage.load(byName: .pinLoginAttemptsLeft) {
                return attempts
            } else {
                return 4
            }
        }
        set { keychainStorage.save(newValue, byName: .pinLoginAttemptsLeft) }
    }

    public var otpId: String? {
        get { return keychainStorage.load(byName: .otpId) }
        set { keychainStorage.save(newValue, byName: .otpId) }
    }

    public var seconds: Int? {
        get { return keychainStorage.load(byName: .seconds) }
        set { keychainStorage.save(newValue, byName: .seconds) }
    }

    public var login: String? {
        get { return keychainStorage.load(byName: .login) }
        set { keychainStorage.save(newValue, byName: .login) }
    }

    var isBiometryUsed: Bool? {
        get { return keychainStorage.load(byName: .isBiometryUsed) }
        set { keychainStorage.save(newValue, byName: .isBiometryUsed) }
    }

    var biometryDomainState: Data? {
        get { return keychainStorage.load(byName: .biometryDomainState) }
        set { keychainStorage.save(newValue, byName: .biometryDomainState) }
    }

    public func flush() {
        keychainStorage.delete(byName: .accessToken)
        keychainStorage.delete(byName: .refreshToken)
        keychainStorage.delete(byName: .pin)
        keychainStorage.delete(byName: .pinLoginAttemptsLeft)
        keychainStorage.delete(byName: .isBiometryUsed)
        keychainStorage.delete(byName: .biometryDomainState)
        keychainStorage.delete(byName: .login)
        keychainStorage.delete(byName: .otpId)
        keychainStorage.delete(byName: .seconds)
    }
}
