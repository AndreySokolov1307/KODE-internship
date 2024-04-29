import UI
import UIKit
import AppIndependent
import Combine

final class OtpInputView: View {
    
    enum Size {
        case small
        case regular
        case big
    }
    
    enum State {
        case input
        case error
    }
    
    // MARK: - Public Properties
    
    @Published public var state: State = .input
    public var didEnterLastDigit: StringHandler?
    public var onClearAll: VoidHandler?
    
    // MARK: - Private Properties
    
    private var isConfigured = false
    private let size: Size
    private var digitItems = [OtpItem]()
    private var lineView = OtpLineView()
    private var textField = TextField()
        .tintColor(.clear)
        .textColor(.clear)
        .keyboardType(.numberPad)
        .contentType(.oneTimeCode)
        .addTarger(target: self, action: #selector(didChange(_:)), for: .editingChanged)
        .isHidden(true)
    private var hStack: HStack!
    private var lineLabelIndex: Int {
        size.numberOfSlots / 2
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - OtpInputView
    
    init(size: Size = Size.big) {
        self.size = size
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    override func setup() {
        super.setup()
        configureLabels()
        textField.delegate = self
        self.embed(subview: textField)
        body().embed(in: self)
        self.onTap { [weak self] in
            self?.textField.shouldBecomeFirstResponder()
        }
        bind()
    }
    
    public func updateUIwithState(_ state: State) {
        switch state {
        case .input:
            digitItems.forEach { item in
                item.label.textColor(.label)
                item.label.text("")
            }
            lineView.lineColor = Palette.Content.tertiary
            textField.shouldBecomeFirstResponder()
            textField.text = ""
            digitItems.first?.lineView.isHidden = false
        case .error:
            digitItems.forEach { labelView in
                labelView.label.textColor(Palette.Indicator.contentError)
            }
            lineView.lineColor = Palette.Indicator.contentError
        }
    }
    
    // MARK: - Private Methods
    
    private func bind() {
        $state
            .removeDuplicates()
            .sink { [weak self] state in
                self?.updateUIwithState(state)
            }
            .store(in: &cancellables)
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
        if text.count == (digitItems.count - 1) && state == .error {
            digitItems.forEach { item in
                item.label.text?.removeAll()
            }
            sender.text = ""
            onClearAll?()
            state = .input
        } else {
            state = .input
            for i in 0 ..< digitItems.count {
                let currentLabel = digitItems[i]
                
                if i < text.count {
                    let index = text.index(text.startIndex, offsetBy: i)
                    currentLabel.label.text = String(text[index])
                    if currentLabel.label.text != nil {
                        currentLabel.hideLineView()
                    }
                } else {
                    state = .input
                    currentLabel.label.text?.removeAll()
                    currentLabel.hideLineView()
                }
            }
            
            if text.count == digitItems.count {
                didEnterLastDigit?(text)
            }
        }
        if let firstEmpty = digitItems.first(where: { $0.label.text == nil || $0.label.text == Common.empty }) {
            firstEmpty.showLineView()
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
