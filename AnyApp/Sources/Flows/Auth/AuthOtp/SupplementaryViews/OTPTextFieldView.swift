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
    
    private var isConfigured = false
    private let numberOfSlots: Int
    private var digitLabels = [OTPLabel]()
    private var lineView = LineView()
    var didEnterLastDigit: StringHandler?
    var lineLabelIndex: Int {
        numberOfSlots / 2
    }
    
    init(numberOfSlots: Int = 7) {
        self.numberOfSlots = numberOfSlots
        super.init()
    }
    
    var hStack = HStack(alignment: .fill, distribution: .equalSpacing)

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
        for i in 1...numberOfSlots {
            if i == lineLabelIndex + 1 {
                hStack
                    .add(arrangedSubview: lineView)
            } else {
                let label = OTPLabel()

                hStack
                    .add(arrangedSubview: label)
                digitLabels.append(label)
            }
        }
        digitLabels.first?.lineView.isHidden = false
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

