import Core
public enum Property {
    case environment(Environment)
    case apnsToken(String)

    case lastUsedAppVersion(String)
    case isOnboardingAlreadyShown(Bool)
    case isPushSetupScreenShown(Bool)
}

enum PropertyKey {
    static let environment = "Environment"
    static let apnsToken = "ApnsToken"

    static let lastUsedAppVersion = "LastUsedAppVersion"
    static let isOnboardingAlreadyShown = "IsOnboardingAlreadyShown"
    static let isPushSetupScreenShown = "IsPushSetupScreenShown"
}
