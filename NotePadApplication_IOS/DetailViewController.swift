import UIKit
import RealmSwift

class MemoData: Object {
    @objc dynamic var title = ""
    @objc dynamic var content = ""
}

class DetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var head: UITextField!
    @IBOutlet weak var content: UITextView!
    
    public static var realm : Realm? = nil
    public static var titleValue = ""
    public static var contentValue = ""
    public static var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        head.delegate = self
        content.delegate = self
        
        head.layer.borderWidth = 1.0
        head.layer.borderColor = UIColor.gray.cgColor
        
        content.layer.borderWidth = 1.0
        content.layer.borderColor = UIColor.gray.cgColor

        if DetailViewController.titleValue != "" && DetailViewController.contentValue != "" {
            var memos = ViewController.reloadMemo(realm: DetailViewController.realm!)
            
            head.text = DetailViewController.titleValue
            content.text = DetailViewController.contentValue
            
            DetailViewController.titleValue = ""
            DetailViewController.contentValue = ""
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        head.resignFirstResponder()
        content.resignFirstResponder()
        
        return true
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            content.resignFirstResponder()
            return false;
        }
        
        return true
    }
    
    func addMemo(memoData : MemoData)  {
        try! DetailViewController.realm?.write {
            DetailViewController.realm?.add(memoData)
        }
    }
    
    func updateMemo(memoData : MemoData, titleV : String, contentV : String) {
        try! DetailViewController.realm?.write {
            memoData.title = titleV
            memoData.content = contentV
        }
    }
    
    @IBAction func saveMemo(_ sender: Any) {
        let memoData = MemoData()
        
        memoData.title = head.text!
        memoData.content = content.text
        
        if DetailViewController.index != -1 {
            var memos = ViewController.reloadMemo(realm: DetailViewController.realm!)
            
            updateMemo(memoData: memos[DetailViewController.index], titleV: head.text!, contentV: content.text)

            DetailViewController.index = -1
        } else {
            addMemo(memoData: memoData)
        }
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateInitialViewController()
        
        self.present(view!, animated: true, completion: nil)
    }
}
