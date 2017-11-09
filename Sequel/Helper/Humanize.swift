class Humanize {
    static func fileSize(bytes: Int) -> String {
        var conversion = Float(bytes)
        var units = ["B", "kB", "MB", "GB", "TB"]
        var unitCount = 0

        while conversion > 1024 {
            conversion /= 1024
            unitCount += 1
        }

        let isConversionInt = conversion.truncatingRemainder(dividingBy: 1) == 0
        let rounded = isConversionInt ? String(format: "%.0f", conversion) : String(format: "%.2f", conversion)

        return "\(rounded) \(units[unitCount])"
    }
}
