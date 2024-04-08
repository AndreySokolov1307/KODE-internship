import UIKit.UIScrollView

public extension UIScrollView {

    @discardableResult
    func horizontalScrollIndicator(show: Bool) -> Self {
        showsHorizontalScrollIndicator = show
        return self
    }

    @discardableResult
    func verticalScrollIndicator(show: Bool) -> Self {
        showsVerticalScrollIndicator = show
        return self
    }

    @discardableResult
    func hidingScrollIndicators() -> Self {
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        return self
    }

    @discardableResult
    func contentInsets(_ insets: UIEdgeInsets) -> Self {
        contentInset = insets
        return self
    }

    @discardableResult
    func contentInsets(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Self {
        contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }

    @discardableResult
    func paging(isEnabled: Bool) -> Self {
        isPagingEnabled = isEnabled
        return self
    }

    @discardableResult
    func delegating(to delegate: UIScrollViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult
    func delayingContentTouches() -> Self {
        delaysContentTouches = true
        return self
    }
}
