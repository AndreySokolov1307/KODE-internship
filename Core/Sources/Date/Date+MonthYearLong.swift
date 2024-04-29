import Foundation

public extension Date {
    var monthYearLongString: String {
        let formatter = DateFormatter()
        formatter.format = .monthYearLong
        return formatter.string(from: self)
    }
}
