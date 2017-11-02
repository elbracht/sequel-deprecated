import UIKit

struct Shadow {
    let color: CGColor
    let opacity: Float
    let offset: CGSize
    let radius: CGFloat
}

extension Shadow {
    static let small = Shadow(
        color: UIColor.black.cgColor,
        opacity: 0.1,
        offset: CGSize(width: 0, height: 1),
        radius: 2
    )

    static let medium = Shadow(
        color: UIColor.black.cgColor,
        opacity: 0.2,
        offset: CGSize(width: 0, height: 2),
        radius: 4
    )

    static let large = Shadow(
        color: UIColor.black.cgColor,
        opacity: 0.3,
        offset: CGSize(width: 0, height: 4),
        radius: 6
    )
}
