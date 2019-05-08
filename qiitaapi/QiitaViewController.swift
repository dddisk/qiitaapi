import UIKit
import SafariServices

// qiitaのapiリストhttps://qiita.com/api/v2/docs
struct QiitaStruct: Codable {
    var title: String
    var url: String
    var user: User
    struct User: Codable {
        var name: String
    }
}


class CustomTableViewCell: UITableViewCell
{
    var contentText:String = "";
    var contentLabel = UILabel();

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.backgroundColor=UIColor.cyan
        contentLabel.font = UIFont.systemFont(ofSize: 22)
        contentLabel.sizeToFit()
        contentLabel.numberOfLines = 0
        self.addSubview(contentLabel);
        self.ajustAutoLayout()
    }

    func ajustAutoLayout()  {

        let top = NSLayoutConstraint(item: self.contentLabel,
                                     attribute: NSLayoutConstraint.Attribute.top,
                                     relatedBy: NSLayoutConstraint.Relation.equal,
                                     toItem: self,
                                     attribute: NSLayoutConstraint.Attribute.top,
                                     multiplier: 1.0,
                                     constant: 30)

        let bottom = NSLayoutConstraint(item: self.contentLabel,
                                        attribute: NSLayoutConstraint.Attribute.bottom,
                                        relatedBy: NSLayoutConstraint.Relation.equal,
                                        toItem: self,
                                        attribute: NSLayoutConstraint.Attribute.bottom,
                                        multiplier: 1.0,
                                        constant: -30)

        let left = NSLayoutConstraint(item: self.contentLabel,
                                      attribute: NSLayoutConstraint.Attribute.leading,
                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                      toItem: self,
                                      attribute: NSLayoutConstraint.Attribute.leading,
                                      multiplier: 1.0,
                                      constant: 50)

        let right = NSLayoutConstraint(item: self.contentLabel,
                                       attribute: NSLayoutConstraint.Attribute.trailing,
                                       relatedBy: NSLayoutConstraint.Relation.equal,
                                       toItem: self,
                                       attribute: NSLayoutConstraint.Attribute.trailing,
                                       multiplier: 1.0,
                                       constant: -50)
        self.addConstraint(top)
        self.addConstraint(bottom)
        self.addConstraint(left)
        self.addConstraint(right)
    }

    func setContentLabelText(text:String){
        let textFontStyle: String = "Helvetica"
        let textFontSize: CGFloat = 20.5
        let textFont = UIFont(name: textFontStyle, size: textFontSize)!
        let textStyle = NSMutableParagraphStyle()
        textStyle.lineSpacing = 18.0
        textStyle.paragraphSpacing = 18.0
        textStyle.alignment = NSTextAlignment.justified
        let attributes: Dictionary = [NSAttributedString.Key.paragraphStyle: textStyle, NSAttributedString.Key.font: textFont]
        let attibute = NSAttributedString(string:text, attributes: attributes)
        self.contentLabel.attributedText = attibute
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
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
    private var tableView = UITableView()
    fileprivate var articles: [QiitaStruct] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "QiitaAPI"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.frame
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        view.addSubview(tableView)
        QiitaViewModel.fetchArticle(completion: { (articles) in
            self.articles = articles
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension QiitaViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.title
        cell.detailTextLabel?.text = article.user.name
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

}

extension QiitaViewController: UITableViewDelegate {


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let articlesurl = articles[indexPath.row]

        let webPage = articlesurl.url
        let safariVC = SFSafariViewController(url: NSURL(string: webPage)! as URL)
        present(safariVC, animated: true, completion: nil)
    }
}
