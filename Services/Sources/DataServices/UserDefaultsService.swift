import Foundation
public protocol UserDefaults: AnyObject {
    func save(string: String?, forKey key: String)
    func save(bool: Bool, forKey key: String)
    func loadString(forKey key: String) -> String?
    func loadBool(forKey key: String) -> Bool
}

final class UserDefaultsService: NSObject, UserDefaults {

    func save(string: String?, forKey key: String) {
        Foundation.UserDefaults.standard.set(string, forKey: key)
    }

    func save(bool: Bool, forKey key: String) {
        Foundation.UserDefaults.standard.set(bool, forKey: key)
    }

    func loadString(forKey key: String) -> String? {
        Foundation.UserDefaults.standard.string(forKey: key)
    }

    func loadBool(forKey key: String) -> Bool {
        Foundation.UserDefaults.standard.bool(forKey: key)
    }
}
