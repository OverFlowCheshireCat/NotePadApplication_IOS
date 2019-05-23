import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mTimer = Timer()
    
    public static var titles : [String] = []
    public static var contents : [String] = []
        
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "메모장 목록"
    }
        
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.titles.count
    }
        
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Re", for: indexPath)
        let row = indexPath.row
            
        cell.textLabel?.text = ViewController.titles[row]
            
        return cell
    }
        
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        ViewController.titles.remove(at: indexPath.row)
        ViewController.contents.remove(at: indexPath.row)
            
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        tableView.delegate = self
        tableView.dataSource = self
        
        mTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { timer in
            self.tableView.reloadData()
        })
    }
}
