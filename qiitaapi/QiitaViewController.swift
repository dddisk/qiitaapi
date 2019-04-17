import UIKit

// qiitaのapiリストhttps://qiita.com/api/v2/docs
struct QiitaStruct: Codable {
    var title: String
    var user: User
    struct User: Codable {
        var name: String
//        var eventUrl: String
//        var startedAt: String
//        private enum CodingKeys: String, CodingKey {
//            case title
//            case eventUrl = "event_url"
//            case startedAt = "started_at"
//        }
    }
}


class QiitaViewModel {
    static func fetchArticle(completion: @escaping ([QiitaStruct]) -> Swift.Void) {

        let url = "https://qiita.com/api/v2/items"

        guard var urlComponents = URLComponents(string: url) else {
            return
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "per_page", value: "50"),
        ]

        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in

            guard let jsonData = data else {
                return
            }

            do {
                let articles = try JSONDecoder().decode([QiitaStruct].self, from: jsonData)
                completion(articles)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
class QiitaViewController: UIViewController {
    let name:String = "s"
    private var tableView = UITableView()
    fileprivate var articles: [QiitaStruct] = []

    let TODO = ["牛乳を買う", "掃除をする", "アプリ開発の勉強をする"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.frame = view.frame
        view.addSubview(tableView)
        QiitaViewModel.fetchArticle(completion: { (articles) in
            self.articles = articles
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}

extension QiitaViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.title
        cell.detailTextLabel?.text = article.user.name
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

}


//class ViewController: UIViewController {
//    var y = 0
//    var number = 0
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
////        fetchX(
////            {x in
////                fetchy(x, {y in
////                    print(x + y)
////            })
////        })
//
//        fetchXplusY { res in
//            print(res)
//        }
//
//
//    }
//
//    func fetchX(_ callback: (Int) -> Void) -> Void {
//        number = 3
//        return callback(number)
//    }
//
//    func fetchy(_ x: Int, _ callback: (Int) -> Void) -> Void {
//        y = x
//        return callback(y)
//    }
//
//    func fetchz(_ x: Int, _ y:Int ,_ callback: (Int) -> Void) -> Void {
//        return callback(3)
//    }
//
//
////    func xplusy2(_ callbackx: Int, _ callbacky: Int,_ callbackxplusy: (Int) -> Void) -> Void{
////        return callbackxplusy(callbackx + callbacky)
////    }
//
//    func fetchXplusY( callback: (Int) -> Void) -> Void{
////        fetchX({callbackx in callbackx}) + fetchy({})
//        fetchX({x in
//            fetchy(x, {y in
//                callback(x + y)
//            })
//        })
//    }
//
//    func fetchxyz( callback: (Int) -> Void) -> Void {
//        fetchX({x in
//            fetchy(x, {y in
//                fetchz(x,y, {z in
//                    callback(x + y + z)
//                })
//            })
//        })
//    }
//}
//

