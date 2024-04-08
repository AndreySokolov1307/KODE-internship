import Swinject

public final class DIContainer {

    public static let shared = DIContainer()

    private let assembler: Assembler

    public var resolver: Resolver { assembler.resolver }

    private var assembled: Set<String> = .init()

    private init() {
        self.assembler = Assembler([])
    }

    public func assemble<T>(assembly: T) where T: Assembly, T: Identifiable {
        guard let id = assembly.id as? String else {
            return
        }
        guard !assembled.contains(id) else {
            return
        }
        assembler.apply(assembly: assembly)
    }
}
