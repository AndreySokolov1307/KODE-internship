import UI
import UIKit
import AppIndependent

final class AuthPhoneView: BackgroundPrimary {

    var onAuth: StringHandler?
    private var logo: UIView {
        ImageView(image: Asset.logoSmall.image)
    }
    var textFieldView = PhoneTextFieldView()
    var logInButton: BaseBrandButton {
        ButtonPrimary(title: Entrance.enter)
            .onTap { [weak self] in
                guard let number = self?.textFieldView.number else { return }
                self?.onAuth?(number)
            }
    }
    override func setup() {
        super.setup()
        body().embed(in: self)
        actionButton = logInButton
        moveActionButtonWithKeyboard = true
    }
    private func body() -> UIView {
        VStack {
            logo
            Spacer(.px20)
            textFieldView
            FlexibleGroupedSpacer()
        }
        .linkGroupedSpacers()
        .layoutMargins(.make(hInsets: 16))
    }
    
    func handleInput(_ input: PhoneTextFieldView.Input) {
        textFieldView.updateUIWithInput(input)
    }
}
