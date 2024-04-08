import Foundation

/// Trait to add ability of post-configure to any object
public protocol Scoped {}

public extension Scoped {

    @inline(__always)
    func also(_ action: (Self) -> Void) -> Self {
        action(self)
        return self
    }
}

extension NSObject: Scoped {}
