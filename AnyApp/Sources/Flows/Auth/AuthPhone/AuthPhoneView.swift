import UI
import UIKit
import Combine
import AppIndependent

final class AuthPhoneView: BackgroundPrimary {
    
    enum State {
        case input
        case error
        case loading
    }

    // MARK: - Public Properties
    
    @Published var state: State = .input
    
    var onAuth: StringHandler?
    
    // MARK: - Private Properties
    
    private let  phoneInputView = PhoneInputView()
    private let logoImageView = ImageView(image: Asset.Images.logoSmall.image, foregroundStyle: .contentAccentTertiary)
    private lazy var logInButton = ButtonPrimary(title: Entrance.enter)
        .onTap { [weak self] in
            guard let number = self?.phoneInputView.number else { return }
            self?.onAuth?(number)
        }
    
    private var cancellables = Set<AnyCancellable>()
       
    // MARK: - Public Methods
    
    override func setup() {
        super.setup()
        body().embed(in: self)
        setupActionButton()
        setupBinding()
    }
    
    // MARK: - Private Methods
    
    private func setupActionButton() {
        actionButton = logInButton
        moveActionButtonWithKeyboard = true
    }
    
    private func body() -> UIView {
        VStack {
            logoImageView
            Spacer(.px20)
            phoneInputView
            FlexibleGroupedSpacer()
        }
        .linkGroupedSpacers()
        .layoutMargins(.make(hInsets: 16))
    }
    
    private func setupBinding() {
        $state
            .sink { [weak self] state in
                self?.updateUIwithState(state)
            }
            .store(in: &cancellables)
    }
    
    private func updateUIwithState(_ state: State) {
        switch state {
        case .input:
            logInButton.stopLoading()
            phoneInputView.updateUIWithState(.input)
        case .error:
            logInButton.stopLoading()
            phoneInputView.updateUIWithState(.error)
        case .loading:
            logInButton.startLoading()
        }
    }
}
