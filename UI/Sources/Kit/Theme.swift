@frozen
public enum Theme: String, CaseIterable, Equatable {
    case light
    case dark
}

@frozen
public enum ThemeRaw: String, CaseIterable {
    case light, dark, auto
}
