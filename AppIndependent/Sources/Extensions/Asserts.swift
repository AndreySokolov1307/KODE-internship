import Foundation

@inline(__always)
public func assertMainThread() {
    assert(Thread.isMainThread)
}
