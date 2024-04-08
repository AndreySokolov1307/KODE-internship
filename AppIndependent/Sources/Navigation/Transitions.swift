public enum TransitionOption {
    // Disable animation, which is enabled by default
    case withoutAnimation
    // Change navigationBar visibility
    case withNavBar(hidden: Bool)
    // Change tabBar visibility
    case withTabBar(hidden: Bool)
    case withCompletion(_ completion: () -> Void)
}

struct TransitionConfig {

    var animate: Bool
    var showNavBar: Bool?
    var showTabBar: Bool?
    var completion: (() -> Void)?

    static func with(options: [TransitionOption]) -> TransitionConfig {
        var config = TransitionConfig()
        options.forEach { option in
            switch option {
            case .withoutAnimation:
                config.animate = false
            case .withNavBar(let hidden):
                config.showNavBar = !hidden
            case .withTabBar(let hidden):
                config.showTabBar = !hidden
            case .withCompletion(let completion):
                config.completion = completion
            }
        }
        return config
    }

    init(
        animate: Bool = true,
        showNavBar: Bool? = nil,
        showTabBar: Bool? = nil,
        completion: (() -> Void)? = nil
    ) {
        self.animate = animate
        self.showNavBar = showNavBar
        self.showTabBar = showTabBar
        self.completion = completion
    }
}
