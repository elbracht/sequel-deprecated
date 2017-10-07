import UIKit
import SnapKit
import Alamofire
import SwiftyJSON

class SearchController: UIViewController {

    var series = [Series]()

    var searchView: SearchView!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        searchView = SearchView()
        searchView.cancelButton.addTarget(self, action: #selector(cancelButtonTouchUpInside), for: .touchUpInside)
        searchView.searchTextField.addTarget(self, action: #selector(searchTextFieldEditingDidBegin), for: .editingDidBegin)
        searchView.searchTextField.addTarget(self, action: #selector(searchTextFieldEditingDidEnd), for: .editingDidEnd)
        self.view.addSubview(searchView)

        searchView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(searchView.height + searchView.insets.top)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @objc func cancelButtonTouchUpInside(sender: UIButton!) {
        self.dismiss(animated: true)
    }

    @objc func searchTextFieldEditingDidBegin(sender: SearchTextField!) {
        sender.animateImageHighlightEnabled()
    }

    @objc func searchTextFieldEditingDidEnd(sender: SearchTextField!) {
        sender.animateImageHighlightDisabled()
    }

    func fetchSeries(searchQuery: String, completion: @escaping () -> Void) {
        let url = "https://api.themoviedb.org/3/search/tv"
        let parameters: Parameters = [ "api_key": TMDb.apiKey, "query": searchQuery ]

        Alamofire.request(url, parameters: parameters).responseJSON { (response) in
            if let json = response.result.value {
                self.parseSeries(json: JSON(json))
                completion()
            }
        }
    }

    func parseSeries(json: JSON) {
        json["results"].forEach({ (_, subJson) in
            let name = subJson["name"].string
            let posterPath = subJson["poster_path"].string

            if name != nil && posterPath != nil {
                series.append(Series(name: name!, posterPath: posterPath!))
            }
        })
    }
}
