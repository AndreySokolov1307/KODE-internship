public protocol ConfigurableView {

    associatedtype Model

    func configure(with model: Model)
}

extension ConfigurableView {

    @discardableResult

    public func configured(with model: Model) -> Self {
        configure(with: model)
        return self
    }
}
