import UIKit
import Alamofire
import AlamofireImage

protocol SeriesDelegate: class {
    func seriesDataAvailable()
}

class Series {
    var name: String
    var posterPath: String
    var image: UIImage?
    weak var delegate: SeriesDelegate?

    init(name: String, posterPath: String) {
        self.name = name
        self.posterPath = posterPath
    }
}

extension Series {
    func load() {
        let url = "https://image.tmdb.org/t/p/w342\(posterPath)"
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value {
                self.image = image
                self.delegate?.seriesDataAvailable()
            }
        }
    }
}
