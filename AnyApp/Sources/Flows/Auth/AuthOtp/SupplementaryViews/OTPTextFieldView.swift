//
//  OTPTextField.swift
//  AnyApp
//
//  Created by Андрей Соколов on 10.04.2024.
//

import UI
import UIKit
import AppIndependent

// swiftlint:disable: trailing_whitespace
final class OTPTextFieldView: View {
    enum Size {
        case small
        case regular
        case big
    }
    
    private var isConfigured = false
    private let size: Size
    private var digitLabels = [OTPLabel]()
    private var lineView = LineView()
    var didEnterLastDigit: StringHandler?
    var lineLabelIndex: Int {
        size.numberOfSlots / 2
    }
    
    init(size: Size = Size.small) {
        self.size = size
        super.init()
    }
    
    var hStack: HStack!

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
        body().embed(in: self)
        self.onTap { [weak self] in
            self?.textField.shouldBecomeFirstResponder()
        }
    }
    
    private func body() -> UIView {
        textField.embed(subview: hStack)
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
        digitLabels.first?.lineView.isHidden = false
    }
    
    private func fillHStack(_ hStack: HStack) {
        for _ in 1...size.numberOfSlots {
                let label = OTPLabel()
                hStack
                    .add(arrangedSubview: label)
                digitLabels.append(label)
        }
    }
    
    @objc private func didChange(_ sender: UITextField) {
        guard let text = textField.text, text.count <= digitLabels.count else { return }
        for i in 0 ..< digitLabels.count {
            let currentLabel = digitLabels[i]
            
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                currentLabel.label.text = String(text[index])
                if currentLabel.label.text != nil {
                    currentLabel.hideLineView()
                }
            } else {
                currentLabel.label.text?.removeAll()
                currentLabel.hideLineView()
            }
        }
        if let firstEmpty = digitLabels.first(where: { $0.label.text == nil || $0.label.text == Common.empty }) {
            firstEmpty.showLineView()
        }
                
        if text.count == digitLabels.count {
            didEnterLastDigit?(text)
        }
    }
}

extension OTPTextFieldView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let characterCount = textField.text?.count else { return false }
        return characterCount < digitLabels.count || string == Common.empty
    }
}

extension OTPTextFieldView.Size {
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
