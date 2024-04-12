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
    private let label = Label()
        .font(UIFont.systemFont(ofSize: 13, weight: .regular))
    private let repeatButton = ImageView(image: Asset.repeat.image, foregroundStyle: .contentAccentPrimary)
    private var timer: Timer?
    private var totalTime = 179
    
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
    
    func updateUIWithState() {
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
                .text(Entrance.repeatAfter + timeFormatted(totalTime + 1))
            startOtpTimer()
        }
    }

    //TODO: - add toggle func to size
    func changeState() {
        state = state == .regular ? .timer : .regular
        updateUIWithState()
    }
    
    private func startOtpTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        print(self.totalTime)
        self.label.text = Entrance.repeatAfter + self.timeFormatted(self.totalTime)
        if totalTime != 0 {
            totalTime -= 1
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
                changeState()
                self.totalTime = 179
            }
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
