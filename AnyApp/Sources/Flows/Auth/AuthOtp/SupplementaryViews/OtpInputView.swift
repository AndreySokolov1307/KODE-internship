//
//  OTPTextField.swift
//  AnyApp
//
//  Created by Андрей Соколов on 10.04.2024.
//

import UI
import UIKit
import AppIndependent

final class OtpInputView: View {
    enum Size {
        case small
        case regular
        case big
    }
    
    enum Input {
        case regular
        case wrong
    }
    
    private var input: Input = .regular
    private var isConfigured = false
    private let size: Size
    private var digitItems = [OtpItem]()
    private var lineView = OtpLineView()
    private var hStack: HStack!
    var didEnterLastDigit: StringHandler?
    var lineLabelIndex: Int {
        size.numberOfSlots / 2
    }
    
    init(size: Size = Size.big) {
        self.size = size
        super.init()
    }

    var textField = TextField()
        .tintColor(.clear)
        .textColor(.clear)
        .keyboardType(.numberPad)
        .contentType(.oneTimeCode)
        .shouldBecomeFirstResponder()
        .addTarger(target: self, action: #selector(didChange(_:)), for: .editingChanged)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        super.setup()
        configureLabels()
        textField.delegate = self
        self.embed(subview: textField)
        body().embed(in: self)
        self.onTap { [weak self] in
            self?.textField.shouldBecomeFirstResponder()
        }
        textField.isHidden(true)
    }
    
    func updateUIWithWrongInput() {
        input = .wrong
        digitItems.forEach { labelView in
            labelView.label.textColor(Palette.Indicator.contentError)
        }
        lineView.lineColor = Palette.Indicator.contentError
    }
    
    private func updateUIWIthRegularInput() {
        digitItems.forEach { labelView in
            labelView.label.textColor(.label)
        }
        lineView.lineColor = Palette.Content.tertiary
   }
    
    private func body() -> UIView {
         hStack
    }
    
    private func configureLabels() {
        guard !isConfigured else { return }
        isConfigured.toggle()
        switch size {
        case .small:
            hStack = HStack(alignment: .fill, distribution: .fill, spacing: 6)
            fillHStack(hStack)
            hStack.insertArrangedSubview(lineView, at: lineLabelIndex)
            hStack.add(arrangedSubview: FlexibleGroupedSpacer())
        case .regular:
            hStack = HStack(alignment: .fill, distribution: .fill, spacing: 6)
            fillHStack(hStack)
            hStack.add(arrangedSubview: FlexibleGroupedSpacer())
        case .big:
            hStack = HStack(alignment: .fill, distribution: .equalSpacing)
            fillHStack(hStack)
            hStack.insertArrangedSubview(lineView, at: lineLabelIndex)
        }
        digitItems.first?.lineView.isHidden = false
    }
    
    private func fillHStack(_ hStack: HStack) {
        for _ in 1...size.numberOfSlots {
                let label = OtpItem()
                hStack
                    .add(arrangedSubview: label)
                digitItems.append(label)
        }
    }
    
    @objc private func didChange(_ sender: UITextField) {
        guard let text = textField.text, text.count <= digitItems.count else { return }
        if input == .wrong {
            input = .regular
            updateUIWIthRegularInput()
        }
        for i in 0 ..< digitItems.count {
            let currentLabel = digitItems[i]
            
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                currentLabel.label.text = String(text[index])
                if currentLabel.label.text != nil {
                    currentLabel.hideLineView()
                }
            } else {
                input = .regular
                currentLabel.label.text?.removeAll()
                currentLabel.hideLineView()
            }
        }
        if let firstEmpty = digitItems.first(where: { $0.label.text == nil || $0.label.text == Common.empty }) {
            firstEmpty.showLineView()
        }
                
        if text.count == digitItems.count {
            didEnterLastDigit?(text)
        }
    }
}

extension OtpInputView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let characterCount = textField.text?.count else { return false }
        return characterCount < digitItems.count || string == Common.empty
    }
}

extension OtpInputView.Size {
    var numberOfSlots: Int {
        switch self {
        case .small:
            return 4
        case .regular:
            return 5
        case .big:
            return 6
        }
    }
}