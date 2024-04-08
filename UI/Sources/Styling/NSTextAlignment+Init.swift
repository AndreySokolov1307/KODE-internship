import UIKit

public extension NSTextAlignment {
    
    init(name: String?) {
        switch name?.lowercased() {
        case "left":
            self = .left
        case "right":
            self = .right
        case "center":
            self = .center
        case "justified":
            self = .justified
        default:
            self = .natural
        }
    }
}
