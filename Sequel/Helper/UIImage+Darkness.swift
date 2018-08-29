import UIKit

extension UIImage {
    var isDark: Bool {
        if let image = self.cgImage {
            guard let imageData = image.dataProvider?.data else { return false }
            guard let ptr = CFDataGetBytePtr(imageData) else { return false }
            let length = CFDataGetLength(imageData)
            let threshold = Int(Double(image.width * image.height) * 0.45)
            var darkPixels = 0
            for byte in stride(from: 0, to: length, by: 4) {
                let red = ptr[byte]
                let green = ptr[byte + 1]
                let blue = ptr[byte + 2]
                let luminance = (0.299 * Double(red) + 0.587 * Double(green) + 0.114 * Double(blue))
                if luminance < 150 {
                    darkPixels += 1
                    if darkPixels > threshold {
                        return true
                    }
                }
            }
        }
        return false
    }
}
