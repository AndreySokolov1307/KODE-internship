import Combine
import UIKit

// swiftlint:disable:next final_class
open class BaseCheckbox: BaseControl {

    // MARK: - Types

    public enum CheckboxState {
        case checked, unchecked
        // for forms where checkbox must be checked to continue
        case uncheckedError
    }

    // MARK: - Private Properties

    @Published public private(set) var checkboxState: CheckboxState = .unchecked

    public var cancellables = Set<AnyCancellable>()

    // MARK: - Public Methods

    override open func setup() {
        super.setup()

        $checkboxState
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                self.updateAppearance()
            }
            .store(in: &cancellables)

        addTarget(self, action: #selector(switcherTapped), for: .valueChanged)
    }

    override open func updateAppearance() {
        super.updateAppearance()

        setupDefaultAppearance()

        switch checkboxState {
        case .checked:
            setupCheckedAppearance()
        case .unchecked:
            setupUncheckedAppearance()
        case .uncheckedError:
            setupUncheckedErrorAppearance()
        }
    }

    open func toggle() {
        switch checkboxState {
        case .checked:
            checkboxState = .unchecked
        case .unchecked, .uncheckedError:
            checkboxState = .checked
        }
    }

    open func set(checkboxState: CheckboxState) {
        self.checkboxState = checkboxState
    }

    // MARK: - Methods to implement

    open func setupDefaultAppearance() { }
    open func setupCheckedAppearance() { }
    open func setupUncheckedAppearance() { }
    open func setupUncheckedErrorAppearance() { }

    // MARK: - Private Methods

    @objc private func switcherTapped() {
        toggle()
    }
}
