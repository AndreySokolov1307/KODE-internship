public extension String {

    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var removingSpaces: String {
        replacingOccurrences(of: " ", with: "")
    }
}
