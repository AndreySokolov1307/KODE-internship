import UIKit

public extension NSUnderlineStyle {
    
    init?(string: String) {
        switch string {
        case "single":
            self = .single
        case "thick":
            self = .thick
        case "double":
            self = .double
        case "patternDot":
            self = .patternDot
        case "patternDash":
            self = .patternDash
        case "patternDashDot":
            self = .patternDashDot
        case "patternDashDotDot":
            self = .patternDashDotDot
        case "byWord":
            self = .byWord
        default:
            return nil
        }
    }
}
