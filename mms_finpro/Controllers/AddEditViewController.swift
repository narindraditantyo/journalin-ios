
import UIKit

class AddEditViewController: UIViewController {

    @IBOutlet weak var inputFeeling: UISegmentedControl!
    @IBOutlet weak var inputDesc: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        inputDesc.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor
        inputDesc.layer.borderWidth = 0.5
        inputDesc.layer.cornerRadius = 5
        
    }

    @IBAction func processAddEdit(_ sender: Any) {
        
    }
}
