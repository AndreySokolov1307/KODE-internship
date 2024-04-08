import Alamofire

final class TrustPolicyManager: ServerTrustManager {
    override func serverTrustEvaluator(forHost host: String) throws -> ServerTrustEvaluating? {
        for (hostName, evaluating) in evaluators {
            if host.contains(hostName) || hostName.contains(host) {
                return evaluating
            }
        }
        return nil
    }
}
