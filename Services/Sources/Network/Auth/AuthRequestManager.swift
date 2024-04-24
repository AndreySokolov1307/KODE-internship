import Core
import Combine
import Alamofire

public protocol AuthRequestManagerAbstract: AnyObject {

    func authLogin(phone: String) -> AppPublisher<AuthLoginResponse>

    func authConfirm(
        otpId: String,
        phone: String,
        otpCode: String
    ) -> AppPublisher<AuthOtpConfirmResponse>
}

final class AuthRequestManager: NetworkRequestManager, AuthRequestManagerAbstract {

    func authLogin(phone: String) -> AppPublisher<AuthLoginResponse> {
        request(
            path: AuthPath.login,
            pathParams: ["number": "151956"],
            params: ["phone": phone]
        )
    }

    func authConfirm(
        otpId: String,
        phone: String,
        otpCode: String
    ) -> AppPublisher<AuthOtpConfirmResponse> {
        request(
            path: AuthPath.confirm,
            pathParams: ["number": "151956"],
            params: [
                "otpId": otpId,
                "phone": phone,
                "otpCode": otpCode
            ]
        )
    }
}
