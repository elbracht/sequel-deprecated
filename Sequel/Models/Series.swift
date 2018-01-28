import Foundation

class Series {
    var id: Int
    var name: String
    var overview: String?
    var posterPath: String
    var episodeRunTime: Int?
    var firstAirDate: Date?
    var lastAirDate: Date?
    var voteAverage: Float?
    var voteCount: Int?
    var homepage: URL?
    var cast: [Actor]?

    init(id: Int, name: String, posterPath: String) {
        self.id = id
        self.name = name
        self.posterPath = posterPath
    }
}
