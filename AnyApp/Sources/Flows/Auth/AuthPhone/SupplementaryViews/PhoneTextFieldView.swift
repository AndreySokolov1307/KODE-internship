//
//  PhoneTextField.swift
//  AnyApp
//
//  Created by Андрей Соколов on 09.04.2024.
//

import UI
import UIKit
import AppIndependent

final class PhoneTextFieldView: View {
    enum Size {
        case medium
        case large
    }
    
    enum Input {
        case right
        case wrong
    }

    var number = Common.empty
    let size: Size
    var textField = TextField(placeholder: Entrance.loginPlaceholder)
        .tintColor(Palette.Content.accentPrimary)
        .keyboardType(.numberPad)
        .contentType(.oneTimeCode)
        .shouldBecomeFirstResponder()
        .addTarger(target: self, action: #selector(didChange(_:)), for: .editingChanged)
    private lazy var imageView = ImageView(image: Asset.Images.phone.image, foregroundStyle: .contentAccentPrimary)
    
    init(size: Size = .large) {
        self.size = size
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        super.setup()
        body().embed(in: self)
            .backgroundColor(Palette.Content.primary)
            .cornerRadius(size.radius)
    }
    private func body() -> UIView {
        HStack(spacing: 16) {
            imageView
            textField
            FlexibleGroupedSpacer()
        }
        .layoutMargins(.make(hInsets: 24))
    }
    
    @objc private func didChange(_ sender: TextField) {
        let pattern = Entrance.phonePattern
        guard let text = sender.text else { return }
        sender.text = text.applyPatternOnNumbers(pattern: pattern,
                                                 replacementCharacter: Character(Entrance.replacementCharacter))
        guard let newText = sender.text else { return }
        number = newText
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.layoutFittingExpandedSize.width, height: size.height)
    }
    
    func updateUIWithInput(_ input: Input) {
        switch input {
        case .right:
            imageView.foregroundStyle(.contentAccentPrimary)
            textField.textColor(Palette.Text.primary)
        case .wrong:
            imageView.foregroundStyle(.indicatorContentError)
            textField.textColor(Palette.Indicator.contentError)
        }
    }
}

extension PhoneTextFieldView.Size {    
    var height: CGFloat {
        switch self {
        case .medium:
            return 40
        case .large:
            return 52
        }
    }
    
    var radius: CGFloat {
        switch self {
        case .medium:
            return 12
        case .large:
            return 26
        }
    }
}

extension String {
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        let string = String(self.prefix(pattern.count))
        var pureNumber = string.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}
