import UIKit
import UI
import Core
import AppIndependent

enum ErrorHandler {
    
    static func getProps(
        for error: AppError,
        comletionHandler: VoidHandler?
    ) -> ErrorView.Props {
        switch error.kind {
        case .timeout:
            return .init(
                title: Common.Error.attentionTitle,
                message: Common.Error.noConnectionMessage2,
                image: Asset.Images.noInternet.image,
                buttonTitle: Common.repeat) {
                    comletionHandler?()
                }
        case .internal, .network, .server, .serverSendWrongData:
            return .init(
                title: Common.Error.defaultMessage,
                message: Common.Error.dataRequestFailMessage,
                image: Asset.Images.commonError.image,
                buttonTitle: Common.repeat) {
                    comletionHandler?()
                }
        }
    }
    
    static func getMessage(for error: AppError) -> String {
        switch error.kind {
        case .timeout:
            return Common.Error.noConnectionMessage
        case .internal, .network, .server, .serverSendWrongData:
            return Common.Error.dataRequestFailMessage
        }
    }
}
