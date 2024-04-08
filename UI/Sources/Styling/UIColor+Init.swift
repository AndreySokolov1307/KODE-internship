import UIKit

public extension UIColor {
    
    enum Error: Swift.Error {
        case wrongColorFormat(format: String)
        case wrongRGBAComponent(format: String)
    }

    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {

        func validated(component value: Int) -> CGFloat {
            guard value > 0 else {
                return 0
            }
            guard value < 256 else {
                return 255
            }
            return CGFloat(value) / 255.0
        }

        func validated(alphaComponent value: CGFloat) -> CGFloat {
            return max(min(value, 1.0), 0)
        }

        let redValidated = validated(component: red)
        let greenValidated = validated(component: green)
        let blueValidated = validated(component: blue)
        let alphaValidated = validated(alphaComponent: alpha)
        self.init(red: redValidated, green: greenValidated, blue: blueValidated, alpha: alphaValidated)
    }

    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xff,
            green: (hex >> 8) & 0xff,
            blue: hex & 0xff
        )
    }

    /**
     Supported formats:
     - hex: "fff", "#fff", "0xFFF"
     - hex with alpha: "FFFFFF11", "0xFFFFFFFF11", "#FFFFFF11"
     */
    convenience init(hexString: String) throws {
        var hexTrimmed = hexString
            .trimmingCharacters(in: CharacterSet.whitespaces)
            .replacingOccurrences(of: "0x", with: "")
            .replacingOccurrences(of: "#", with: "")

        switch hexTrimmed.count {
        case 3:
            // short hex: "#fff"
            hexTrimmed = hexTrimmed.map(String.init).map({ return $0+$0 }).joined()
            fallthrough

        case 6, 8:
            // default hex: "#ffffff"
            // or hex with alpha: "#ffffffff"

            var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
            hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

            var rgb: UInt64 = 0

            var red: CGFloat = 0.0
            var green: CGFloat = 0.0
            var blue: CGFloat = 0.0
            var alpha: CGFloat = 1.0

            guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
                throw Error.wrongColorFormat(format: hexSanitized)
            }

            if hexTrimmed.count == 6 {
                red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
                green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
                blue = CGFloat(rgb & 0x0000FF) / 255.0
            } else {
                red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
                green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
                blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
                alpha = CGFloat(rgb & 0x000000FF) / 255.0
            }
            self.init(red: red, green: green, blue: blue, alpha: alpha)

        default:
            throw Error.wrongColorFormat(format: hexString)
        }
    }

    /**
     Supported formats:
     - RBG: ""0, 153, 204", "0,255,0"
     - RGBA: "102, 0, 255, 0.5", 102,0,255,0.3"
     */
    convenience init(rgbaString: String) throws {
        let componentStrings = rgbaString
            .replacingOccurrences(of: " ", with: "")
            .split(separator: ",")
            .map(String.init)

        guard [3, 4].contains(componentStrings.count) else {
            throw Error.wrongColorFormat(format: rgbaString)
        }

        func rgbComponent(_ value: String) throws -> Int {
            guard let val = Int(value) else {
                throw Error.wrongRGBAComponent(format: value)
            }
            return val
        }

        func alphaComponent(_ value: String) throws -> CGFloat {
            guard let val = Double(value) else {
                throw Error.wrongRGBAComponent(format: value)
            }
            return CGFloat(val)
        }

        if componentStrings.count == 3 {
            self.init(
                red: try rgbComponent(componentStrings[0]),
                green: try rgbComponent(componentStrings[1]),
                blue: try rgbComponent(componentStrings[2])
            )
        } else {
            self.init(
                red: try rgbComponent(componentStrings[0]),
                green: try rgbComponent(componentStrings[1]),
                blue: try rgbComponent(componentStrings[2]),
                alpha: try alphaComponent(componentStrings[3])
            )
        }
    }
}
