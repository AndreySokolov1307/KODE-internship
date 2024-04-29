import UI
import UIKit
import AppIndependent
import Combine

final class AuthOtpView: BackgroundPrimary {
    
    enum State {
        case input
        case error(String)
        case loading
    }
    
    // MARK: - Public Properties

    @Published var state: State = .input
    
    var onOtpFilled: StringHandler?
    var onOtpRepeat: VoidHandler?
    
    let otpInputView = OtpInputView()
    
    // MARK: - Private Properties
    
    private let label = Label(text: Entrance.otpLabel, foregroundStyle: .textPrimary, fontStyle: .body2)
        .multiline()
    private let otpRepeatView = OtpRepeatView()
    
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Public Methods
    
    override func setup() {
        super.setup()
        body().embed(in: self)
        bind()
        configureActions()
    }
    
    // MARK: - Private Methods
    
    private func configureActions() {
        otpInputView.didEnterLastDigit = { [weak self] otp in
            self?.onOtpFilled?(otp)
        }
        otpInputView.onClearAll = { [weak self] in
            self?.state = .input
        }
        otpRepeatView.onRepeatViewTap = { [weak self] in
            self?.onOtpRepeat?()
        }
    }
    
    private func bind() {
        $state
            .sink { [weak self] state in
                self?.updateUIwithState(state)
            }
            .store(in: &cancellables)
    }
    
    private func updateUIwithState(_ state: State) {
        switch state {
        case .input:
            otpRepeatView.state = .timer
            otpInputView.state = .input
        case .error(let message):
            otpRepeatView.state = .error(message)
            otpInputView.state = .error
        case .loading:
            break
        }
    }

    public func stopTimer() {
        otpRepeatView.timer?.invalidate()
        otpRepeatView.timer = nil
    }
    
    private func body() -> UIView {
        VStack {
            label
            Spacer(.px24)
            otpInputView
            Spacer(.px24)
            otpRepeatView
            FlexibleSpacer()
        }.layoutMargins(.make(vInsets: 16, hInsets: 16))
    }
}

