//
//  OTPRepeatView.swift
//  AnyApp
//
//  Created by Андрей Соколов on 11.04.2024.
//

import UI
import UIKit
import AppIndependent

final class OTPRepeatView: View {
    enum State {
        case regular
        case timer
    }
    
    var state = State.timer
    var onRepeatButtonTap: VoidHandler?
    var timer: Timer?
    
    private let label = Label(foregroundStyle: .textSecondary ,fontStyle: .caption1)
    private let repeatButton = ImageView(image: Asset.Images.repeat.image, foregroundStyle: .contentAccentPrimary)
    private let defaultTime: Int
    private lazy var timeleft = defaultTime
    
    init(defaultTime: Int = 179) {
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
    
    override func setup() {
        super.setup()
        updateUIWithState()
        body().embed(in: self)
    }
    
    private func body() -> UIView {
        HStack(alignment: .fill, distribution: .fill, spacing: 16) {
            repeatButton
                .onTap { [weak self] in
                    self?.changeState()
                    self?.onRepeatButtonTap?()
                }
            label
            FlexibleGroupedSpacer()
        }
    }
    
    public func updateUIWithWrongInputMessage(_ message: String) {
        timer?.invalidate()
        repeatButton
            .isHidden(true)
        label
            .text(message)
            .textColor(Palette.Indicator.contentError)
    }
    
   private func updateUIWithState() {
        switch state {
        case .regular:
            repeatButton
                .isHidden(false)
            label
                .text(Entrance.sendOTPAgain)
                .foregroundStyle(.textPrimary)
        case .timer:
            repeatButton.isHidden = true
            label
                .foregroundStyle(.textSecondary)
                .text(Entrance.repeatAfter + timeFormatted(timeleft + 1))
            startOtpTimer()
        }
    }
    
    private func changeState() {
        state.toggle()
        updateUIWithState()
    }
    
    private func startOtpTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        self.label.text = Entrance.repeatAfter + self.timeFormatted(self.timeleft)
        if timeleft != 0 {
            timeleft -= 1
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
                changeState()
                self.timeleft = defaultTime
            }
        }
    }
    
    private func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension OTPRepeatView.State {
    mutating func toggle() {
        self = self == .regular ? .timer : .regular
    }
}
