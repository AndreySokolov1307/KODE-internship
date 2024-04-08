import UIKit

public extension UILabel {

    private func addSymbol(
        _ symbol: String,
        withText text: String,
        symbolColor: UIColor,
        textAttributes: [NSAttributedString.Key: Any]
    ) -> NSAttributedString {
        let symbolAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: symbolColor]
        
        let mutableAttributed = NSMutableAttributedString()
        let formattedString = "\(symbol) \(text)"
        let attributedString = NSMutableAttributedString(string: formattedString)
        attributedString.addAttributes(
            textAttributes,
            range: NSMakeRange(0, attributedString.length)
        )
        
        let string: NSString = NSString(string: formattedString)
        let symbolRange: NSRange = string.range(of: symbol)
        attributedString.addAttributes(symbolAttributes, range: symbolRange)
        mutableAttributed.append(attributedString)
        
        return mutableAttributed
    }
}
