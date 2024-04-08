import UIKit

// swiftlint:disable:next final_class
open class VStack: BaseStackView {

    override open func setup() {
        axis = .vertical
        super.setup()
    }
}
