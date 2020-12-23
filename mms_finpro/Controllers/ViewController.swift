
import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 5
        registerButton.layer.borderColor = UIColor(red: 42/255, green: 157/255, blue: 143/255, alpha: 1).cgColor
        registerButton.layer.borderWidth = 1
        registerButton.layer.cornerRadius = 5
        
    }
    
}

