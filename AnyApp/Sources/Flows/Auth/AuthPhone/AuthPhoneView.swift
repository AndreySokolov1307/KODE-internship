import UI
import UIKit
import AppIndependent

final class AuthPhoneView: BackgroundPrimary {

    var onAuth: StringHandler?
    private let logo = ImageView(image: Asset.Images.logoSmall.image)
    var textFieldView = PhoneTextFieldView()
    lazy var logInButton = ButtonPrimary(title: Entrance.enter)
        .onTap { [weak self] in
            guard let number = self?.textFieldView.number else { return }
            self?.onAuth?(number)
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
