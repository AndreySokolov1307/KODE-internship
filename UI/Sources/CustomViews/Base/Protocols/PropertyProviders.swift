import UIKit

public protocol ProvidesHeight: AnyObject {
    var height: CGFloat { get }
}

public protocol ProvidesName {
    var name: String { get }
}

public protocol ProvidesSize: AnyObject {
    var size: CGSize { get }
}
