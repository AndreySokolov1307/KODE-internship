import UI
import UIKit
import AppIndependent
import Combine

final class OtpRepeatView: View {
    
    enum State: Equatable {
        case error(String)
        case timer
    }
    
    // MARK: - Public Properties
    
    @Published var state: State = .timer
    var onRepeatViewTap: VoidHandler?
    var timer: Timer?
    
    // MARK: - Private Properties
    
    private let label = Label(foregroundStyle: .textSecondary, fontStyle: .caption1)
    private let repeatView = ImageView(image: Asset.Images.repeat.image, foregroundStyle: .contentAccentPrimary)
    private let defaultTime: Int
    private lazy var timeleft = defaultTime
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - OtpRepeatView
    
    init(defaultTime: Int = 4) {
        if defaultTime <= 0 {
            self.defaultTime = 59
        } else {
            self.defaultTime = defaultTime
        }
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    override func setup() {
        super.setup()
        body().embed(in: self)
        startOtpTimer()
        bind()
    }
    
    // MARK: - Private Methods
    
    private func bind() {
        $state
            .sink { [weak self] state in
                self?.updateUIWithState(state)
            }
            .store(in: &cancellables)
    }
    
    private func updateUIWithState(_ state: State) {
        switch state {
        case .timer:
            if let timer = timer, timer.isValid {
                repeatView.isHidden(true)
                label
                    .foregroundStyle(.textSecondary)
                    .text(Entrance.repeatAfter + timeFormatted(timeleft + 1))
            } else {
                repeatView.isHidden(false)
                label
                    .text(Entrance.sendOTPAgain)
                    .foregroundStyle(.textPrimary)
            }
        case .error(let message):
            repeatView.isHidden(true)
            label
                .text(message)
                .foregroundStyle(.indicatorContentError)
        }
    }

    private func body() -> UIView {
        HStack(alignment: .fill, distribution: .fill, spacing: 16) {
            repeatView
                .onTap { [weak self] in
                    self?.startOtpTimer()
                    self?.state = .timer
                    self?.onRepeatViewTap?()
                }
            label
            FlexibleGroupedSpacer()
        }
    }
    
    private func startOtpTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if state == .timer {
            self.label.text = Entrance.repeatAfter + self.timeFormatted(self.timeleft)
        }
        if timeleft != 0 {
            timeleft -= 1
        } else {
            timer?.invalidate()
            self.state = .timer
            self.timeleft = defaultTime
        }
    }
    
    private func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
