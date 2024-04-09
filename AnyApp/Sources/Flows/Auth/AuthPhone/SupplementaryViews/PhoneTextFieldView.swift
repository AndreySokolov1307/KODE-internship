//
//  PhoneTextField.swift
//  AnyApp
//
//  Created by Андрей Соколов on 09.04.2024.
//

import UI
import UIKit
import AppIndependent

// swiftlint:disable: trailing_whitespace
final class PhoneTextFieldView: View {
    enum Size {
        case medium
        case large
    }

    var number = Common.empty
    let size: Size
    var textField: TextField {
        TextField(placeholder: Common.loginPlaceholder)
            .tintColor(Palette.Content.contentAccentPrimary)
            .keyboardType(.numberPad)
            .contentType(.oneTimeCode)
            .shouldBecomeFirstResponder()
            .addTarger(target: self, action: #selector(didChange(_:)), for: .editingChanged)
    }
    
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
            ImageView(image: Asset.phone.image)
            textField
            FlexibleGroupedSpacer()
        }
        .layoutMargins(.make(hInsets: 24))
    }
    
    @objc private func didChange(_ sender: TextField) {
        let pattern = Common.phonePattern
        guard let text = sender.text else { return }
        sender.text = text.applyPatternOnNumbers(pattern: pattern,
                                                 replacementCharacter: Character(Common.replacementCharacter))
        guard let newText = sender.text else { return }
        number = newText
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.layoutFittingExpandedSize.width, height: size.height)
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
