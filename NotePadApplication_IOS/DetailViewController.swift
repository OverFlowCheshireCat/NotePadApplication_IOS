import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var head: UITextField!
    @IBOutlet weak var content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        head.delegate = self
        content.delegate = self
        
        head.layer.borderWidth = 1.0
        head.layer.borderColor = UIColor.gray.cgColor
        
        content.layer.borderWidth = 1.0
        content.layer.borderColor = UIColor.gray.cgColor
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
    
    @IBAction func saveMemo(_ sender: Any) {
        ViewController.titles.append(head.text!)
        ViewController.contents.append(content.text)
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateInitialViewController()
        self.present(view!, animated: true, completion: nil)
    }
}
