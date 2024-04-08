import UIKit

extension UIScrollView {

    var isTopEdge: Bool {
        return contentOffset.y < 0
    }

    var isNotTopEdge: Bool {
        return !isTopEdge
    }

    var isBottomEdge: Bool {
        var overSize = contentSize.height - bounds.size.height
        overSize = max(overSize, 0.0)
        return contentOffset.y > overSize
    }

    var isNotBottomEdge: Bool {
        return !isBottomEdge
    }

    var isVerticalEdge: Bool {
        return isTopEdge || isBottomEdge
    }

    var isNotVerticalEdge: Bool {
        return !isVerticalEdge
    }

    var isLeftEdge: Bool {
        return contentOffset.x < 0
    }

    var isNotLeftEdge: Bool {
        return !isLeftEdge
    }

    var isRightEdge: Bool {
        return contentOffset.x > (contentSize.width - bounds.size.width)
    }

    var isNotRightEdge: Bool {
        return !isRightEdge
    }

    var isHorizontalEdge: Bool {
        return isLeftEdge || isRightEdge
    }

    var isNotHorizontalEdge: Bool {
        return !isHorizontalEdge
    }

    var isOnEdge: Bool {
        return isVerticalEdge || isHorizontalEdge
    }

    var isNotOnEdge: Bool {
        return !isOnEdge
    }
}
