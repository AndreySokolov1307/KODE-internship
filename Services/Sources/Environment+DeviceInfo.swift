import UIKit
import LocalAuthentication
import AppIndependent

public struct BaseDeviceInfo: Encodable {

    public let platform: String
    public let osVersion: String
    public let brandName: String
    public let model: String
    public let identifierForVendor: String
    public let screenResolution: String
    public let appVersion: String
    public let isRooted: Bool
    public let isProtected: Bool

    public init(
        platform: String,
        osVersion: String,
        brandName: String,
        model: String,
        identifierForVendor: String,
        screenResolution: String,
        appVersion: String,
        isRooted: Bool,
        isProtected: Bool
    ) {
        self.platform = platform
        self.osVersion = osVersion
        self.brandName = brandName
        self.model = model
        self.identifierForVendor = identifierForVendor
        self.screenResolution = screenResolution
        self.appVersion = appVersion
        self.isRooted = isRooted
        self.isProtected = isProtected
    }
}
