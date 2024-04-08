import UIKit

public struct GradientProps {

    public enum Direction {
        case vertical, horizontal
        case custom(startPoint: CGPoint, endPoint: CGPoint)

        public var startPoint: CGPoint {
            switch self {
            case .vertical, .horizontal:
                return CGPoint.zero
            case .custom(let startPoint, _):
                return startPoint
            }
        }

        public var endPoint: CGPoint {
            switch self {
            case .vertical:
                return CGPoint(x: 0, y: 1)
            case .horizontal:
                return CGPoint(x: 1, y: 0)
            case .custom(_, let endPoint):
                return endPoint
            }
        }
    }

    public let colors: [UIColor]
    public let direction: Direction
    public let locations: [CGFloat]?

    public init(colors: [UIColor], direction: Direction, locations: [CGFloat]? = nil) {
        self.colors = colors
        self.direction = direction
        self.locations = locations
    }
}
