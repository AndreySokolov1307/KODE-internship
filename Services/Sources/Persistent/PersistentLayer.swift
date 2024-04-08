import Core
import Combine

public protocol Persistent: AnyObject {
    func set(_ property: Property)

    var keychainStorage: KeychainStorage { get }

    var environment: Environment { get }
    var apnsToken: String? { get }

    // Auth Properties
    var lastUsedAppVersion: String? { get }
    var isFirstLaunch: Bool { get }
    var isOnboardingFlowShown: Bool { get }
    var isPushSetupScreenShown: Bool { get }
}

final class PersistentLayer: Persistent {

    let keychainStorage: KeychainStorage
    let userDefaultsStorage: UserDefaults
    let sessionStorage: SessionStorage

    var environment: Environment
    var apnsToken: String?

    var lastUsedAppVersion: String?

    // Auth Properties
    var isFirstLaunch: Bool { lastUsedAppVersion == nil }
    var isOnboardingFlowShown: Bool
    var isPushSetupScreenShown: Bool

    init() {
        keychainStorage = KeychainStorageService()
        userDefaultsStorage = UserDefaultsService()
        sessionStorage = SessionStorage(keychainStorage: keychainStorage)

        if
            let environmentName = userDefaultsStorage.loadString(forKey: PropertyKey.environment),
            let savedEnvironment = Environment.named(environmentName) {
            environment = savedEnvironment
        } else {
            #if DEV
            environment = Environment.dev
            #elseif INT
            environment = Environment.internal
            #elseif EXT
            environment = Environment.external
            #else
            environment = Environment.release
            #endif
        }

        apnsToken = userDefaultsStorage.loadString(forKey: PropertyKey.apnsToken)
        lastUsedAppVersion = userDefaultsStorage.loadString(forKey: PropertyKey.lastUsedAppVersion)
        isOnboardingFlowShown = userDefaultsStorage.loadBool(forKey: PropertyKey.isOnboardingAlreadyShown)
        isPushSetupScreenShown = userDefaultsStorage.loadBool(forKey: PropertyKey.isPushSetupScreenShown)
    }

    func set(_ property: Property) {
        switch property {
        case .environment(let environment):
            self.environment = environment
            userDefaultsStorage.save(string: environment.name, forKey: PropertyKey.environment)
        case .apnsToken(let apnsToken):
            self.apnsToken = apnsToken
            userDefaultsStorage.save(string: apnsToken, forKey: PropertyKey.apnsToken)
        case .isOnboardingAlreadyShown(let isShown):
            isOnboardingFlowShown = isShown
            userDefaultsStorage.save(bool: isShown, forKey: PropertyKey.isOnboardingAlreadyShown)
        case .isPushSetupScreenShown(let isShown):
            isPushSetupScreenShown = isShown
            userDefaultsStorage.save(bool: isShown, forKey: PropertyKey.isPushSetupScreenShown)
        case .lastUsedAppVersion(let version):
            lastUsedAppVersion = version
            userDefaultsStorage.save(string: version, forKey: PropertyKey.lastUsedAppVersion)
        }
    }
}
