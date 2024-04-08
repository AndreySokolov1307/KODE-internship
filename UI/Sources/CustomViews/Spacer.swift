import UIKit

public final class Spacer: BaseSpacer {

    public enum Style {
        case px72, px68, px48, px36, px32, px24, px20, px16, px12, px8, px6, px4, px2
        case custom(length: CGFloat)
    }

    convenience public init(_ style: Style) {
        self.init(length: style.length)
    }
}

extension Spacer.Style {

    var length: CGFloat {
        switch self {
        case .px72: return 72
        case .px68: return 68
        case .px48: return 48
        case .px36: return 36
        case .px32: return 32
        case .px24: return 24
        case .px20: return 20
        case .px16: return 16
        case .px12: return 12
        case .px8: return 8
        case .px6: return 6
        case .px4: return 4
        case .px2: return 2
        case .custom(let length): return length
        }
    }
}
