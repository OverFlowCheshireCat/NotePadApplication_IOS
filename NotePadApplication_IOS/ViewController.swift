import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var realm = try! Realm()
        
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "메모장 목록"
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var memos = ViewController.reloadMemo(realm: realm)
        
        return memos.count
    }
        
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Re", for: indexPath)
        let row = indexPath.row
        
        var memos = ViewController.reloadMemo(realm: realm)
        
        cell.textLabel?.text = memos[row].title
            
        return cell
    }
        
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        var memos = ViewController.reloadMemo(realm: realm)

        deleteMemo(memoData: memos[indexPath.row])
                
        tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var memos = ViewController.reloadMemo(realm: realm)
        
        DetailViewController.realm = realm
        DetailViewController.titleValue = memos[indexPath.row].title
        DetailViewController.contentValue = memos[indexPath.row].content
        DetailViewController.index = indexPath.row
    }
    
    public static func reloadMemo(realm : Realm) -> Results<MemoData> {
        var memos: Results<MemoData> {
            
            get {
                return realm.objects(MemoData.self)
            }
        }
        
        return memos
    }
    
    func deleteMemo(memoData : MemoData)  {
        try! realm.write {
            realm.delete(memoData)
        }
    }
    
    @IBAction func writeMemo(_ sender: Any) {
        DetailViewController.titleValue = ""
        DetailViewController.contentValue = ""
        DetailViewController.index = -1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}
