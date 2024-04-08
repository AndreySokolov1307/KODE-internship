import UIKit

public extension UICollectionView {

    func isIndexPathAvailable(_ indexPath: IndexPath) -> Bool {
        guard dataSource != nil,
            indexPath.section < numberOfSections,
            indexPath.item < numberOfItems(inSection: indexPath.section)
            else { return false }
        
        return true
    }
    
    func scrollToItemIfAvailable(at indexPath: IndexPath,
                                 at scrollPosition: UICollectionView.ScrollPosition,
                                 animated: Bool) {
        guard isIndexPathAvailable(indexPath) else { return }
        
        scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }
    
    func scrollToItemOrThrow(at indexPath: IndexPath,
                             at scrollPosition: UICollectionView.ScrollPosition,
                             animated: Bool) throws {
        guard isIndexPathAvailable(indexPath) else {
            throw Error.invalidIndexPath(indexPath: indexPath,
                                         lastIndexPath: lastIndexPath)
        }
        
        scrollToItem(at: indexPath,
                     at: scrollPosition,
                     animated: animated)
    }
    
    var lastIndexPath: IndexPath {
        let lastSection = numberOfSections - 1
        return IndexPath(item: numberOfItems(inSection: lastSection) - 1, section: lastSection)
    }
}

public extension UICollectionView {
    
    enum Error: Swift.Error, CustomStringConvertible {
        case invalidIndexPath(indexPath: IndexPath, lastIndexPath: IndexPath)
        public var description: String {
            switch self {
            case let .invalidIndexPath(indexPath, lastIndexPath):
                return "IndexPath \(indexPath) is not available. The last available IndexPath is \(lastIndexPath)"
            }
        }
    }
}
