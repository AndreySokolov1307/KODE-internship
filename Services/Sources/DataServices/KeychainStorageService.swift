import Foundation
import KeychainAccess
import AppIndependent

// MARK: - KeychainStorage
// swiftlint:disable final_class
public protocol KeychainStorage: AnyObject {
    func contains(byName name: KeychainStorageService.Name) -> Bool
    func load<Type>(byName name: KeychainStorageService.Name) -> Type?
    func save(_ value: Any?, byName name: KeychainStorageService.Name)
    func delete(byName name: KeychainStorageService.Name)
    func flushStorage()
}

// MARK: - KeychainStorage

public final class KeychainStorageService: KeychainStorage {

    private static let keychain: Keychain = {
        guard let service = Bundle.main.infoDictionary?[String(kCFBundleIdentifierKey)] as? String else {
            fatalError("Failed to resolve bundle identifier from .plist dict")
        }

        return Keychain(service: service)
            .accessibility(.afterFirstUnlock)
    }()

    private var keychain: Keychain {
        return KeychainStorageService.keychain
    }

    public enum Name: String {
        case otpId
        case login
        case clientId
        case pin
        case pinLoginAttemptsLeft
        case accessToken
        case refreshToken
        case isBiometryUsed
        case biometryDomainState
        case deviceId
        case lastTimeAppWasInForeground
        case seconds
    }

    public func contains(byName name: Name) -> Bool {
        let name = name.rawValue
        do {
            if
                let data = try keychain.getData(name),
                let dictionary = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String: Any]
            {
                return dictionary[name] != nil
            }
        } catch {
            Logger().log(error.localizedDescription)
        }
        return false
    }

    public func load<Type>(byName name: Name) -> Type? {
        let name = name.rawValue
        do {
            if
                let data = try keychain.getData(name),
                let dictionary = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String: Any],
                let value = dictionary[name] as? Type {
                return value
            }
        } catch {
            assertionFailure(error.localizedDescription)
        }
        return nil
    }

    public func save(_ value: Any?, byName name: Name) {
        guard let value = value else {
            delete(byName: name)
            return
        }
        let name = name.rawValue
        do {
            let data = [name: value]
            try keychain.set(NSKeyedArchiver.archivedData(withRootObject: data,
                                                          requiringSecureCoding: false),
                             key: name)
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }

    public func delete(byName name: Name) {
        let name = name.rawValue
        do {
            try keychain.remove(name)
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }

    public func flushStorage() {
        do {
            try keychain.removeAll()
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}
