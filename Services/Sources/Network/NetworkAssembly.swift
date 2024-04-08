public final class NetworkFactory {

    private let network: Network

    public init(network: Network) {
        self.network = network
    }

    public func makeAuthRequestManager() -> AuthRequestManagerAbstract {
        AuthRequestManager(
            errorParser: network.errorParser,
            sessionManager: network.sessionManager,
            environment: network.environment,
            queue: network.defaultQueue,
            session: network.session
        )
    }
}
