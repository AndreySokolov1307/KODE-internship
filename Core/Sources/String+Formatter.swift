import Foundation

public extension String {
  public static func format(
        _ string: String,
        with mask: String,
        replacingChar: Character,
        passingChar: Character
    ) -> String {
        let numbers = string.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        for ch in mask where index < numbers.endIndex {
            if ch == replacingChar {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else if ch == passingChar {
                result.append(ch)
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
