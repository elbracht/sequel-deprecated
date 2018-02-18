import UIKit

struct Color {
    struct Primary {
        static let normal = UIColor(hue: 0.58, saturation: 0.70, brightness: 0.80, alpha: 1.00)
        static let highlight = UIColor(hue: 0.58, saturation: 0.70, brightness: 0.80, alpha: 0.32)
    }

    struct Background {
        static let light = UIColor(hue: 0.00, saturation: 0.00, brightness: 0.96, alpha: 1.00)
        static let dark = UIColor(hue: 0.70, saturation: 0.11, brightness: 0.18, alpha: 1.00)
    }

    struct Black {
        static let primary = UIColor.black.withAlphaComponent(0.87)
        static let secondary = UIColor.black.withAlphaComponent(0.54)
        static let disabled = UIColor.black.withAlphaComponent(0.38)
        static let divider = UIColor.black.withAlphaComponent(0.12)
    }

    struct White {
        static let primary = UIColor.white.withAlphaComponent(1)
        static let secondary = UIColor.white.withAlphaComponent(0.7)
        static let disabled = UIColor.white.withAlphaComponent(0.5)
        static let divider = UIColor.white.withAlphaComponent(0.12)
    }
}
