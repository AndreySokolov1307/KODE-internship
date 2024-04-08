import UIKit.UIStackView

#if swift(>=5.4)
@resultBuilder
public struct ForEachBuilder {

    public static func buildBlock(_ args: UIView...) -> [UIView] {
        return args
    }
}

#else

@_resultBuilder
public struct ForEachBuilder {
    public static func buildBlock(_ args: UIView...) -> [UIView] {
        return args
    }
}
#endif

public final class ForEach<T>: BaseStackView where T: Collection {

    // MARK: - Init

    public required init(
        collection: T,
        alignment: UIStackView.Alignment = .center,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 0,
        axis: NSLayoutConstraint.Axis = .vertical,
        @ForEachBuilder content: @escaping (T.Element) -> [UIView]
    ) {
        super.init(axis: axis, alignment: alignment, distribution: distribution, spacing: spacing)
        layoutCollection(collection, generator: content)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func layoutCollection(_ collection: T, generator: (T.Element) -> [UIView]) {
        set(arrangedSubviews: collection.compactMap { item -> UIView? in
            let subviews = generator(item)

            if subviews.isEmpty {
                return nil
            }

            if subviews.count == 1 {
                return subviews.first
            }

            let stack = BaseStackView()
            stack.axis = axis
            stack.alignment = alignment
            stack.distribution = distribution
            stack.add(arrangedSubviews: subviews)
            return stack
        })
    }
}
