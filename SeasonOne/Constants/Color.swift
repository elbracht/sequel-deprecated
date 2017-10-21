import UIKit

struct Color {
    let background: UIColor
    let accent: UIColor

    let blackPrimary: UIColor
    let blackSecondary: UIColor
    let blackDisabled: UIColor
    let blackDivider: UIColor

    let whitePrimary: UIColor
    let whiteSecondary: UIColor
    let whiteDisabled: UIColor
    let whiteDivider: UIColor

    static let light = Color(
        background: UIColor(hue: 0.00, saturation: 0.00, brightness: 0.96, alpha: 1.00),
        accent: UIColor(hue: 0.58, saturation: 0.70, brightness: 0.80, alpha: 1.00),
        blackPrimary: UIColor.black.withAlphaComponent(0.87),
        blackSecondary: UIColor.black.withAlphaComponent(0.54),
        blackDisabled: UIColor.black.withAlphaComponent(0.38),
        blackDivider: UIColor.black.withAlphaComponent(0.12),
        whitePrimary: UIColor.white.withAlphaComponent(1),
        whiteSecondary: UIColor.white.withAlphaComponent(0.7),
        whiteDisabled: UIColor.white.withAlphaComponent(0.5),
        whiteDivider: UIColor.white.withAlphaComponent(0.12)
    )
}
