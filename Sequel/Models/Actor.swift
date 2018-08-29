import Foundation

class Actor {
    var id: Int
    var character: String
    var name: String
    var posterPath: String

    init(id: Int, character: String, name: String, posterPath: String) {
        self.id = id
        self.character = character
        self.name = name
        self.posterPath = posterPath
    }
}
