import UIKit

struct Color {
    let background: String

    let accentNormal: String
    let accentHighlighted: String

    let blackPrimary: String
    let blackSecondary: String
    let blackDisabled: String
    let blackDivider: String

    let whitePrimary: String
    let whiteSecondary: String
    let whiteDisabled: String
    let whiteDivider: String

    static let light = Color(
        background: UIColor(hue: 0.00, saturation: 0.00, brightness: 0.96, alpha: 1.00).hexString(true),
        accentNormal: UIColor(hue: 0.58, saturation: 0.70, brightness: 0.80, alpha: 1.00).hexString(true),
        accentHighlighted: UIColor(hue: 0.58, saturation: 0.70, brightness: 0.80, alpha: 0.32).hexString(true),
        blackPrimary: UIColor.black.withAlphaComponent(0.87).hexString(true),
        blackSecondary: UIColor.black.withAlphaComponent(0.54).hexString(true),
        blackDisabled: UIColor.black.withAlphaComponent(0.38).hexString(true),
        blackDivider: UIColor.black.withAlphaComponent(0.12).hexString(true),
        whitePrimary: UIColor.white.withAlphaComponent(1).hexString(true),
        whiteSecondary: UIColor.white.withAlphaComponent(0.7).hexString(true),
        whiteDisabled: UIColor.white.withAlphaComponent(0.5).hexString(true),
        whiteDivider: UIColor.white.withAlphaComponent(0.12).hexString(true)
    )
}
