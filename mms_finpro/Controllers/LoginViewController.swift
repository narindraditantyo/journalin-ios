
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Login"
        loginButton.layer.cornerRadius = 5
        
    }

    @IBAction func processLogin(_ sender: Any) {
        
        var errorMessage: String = ""
        var loginError: Bool = false
        
        if !inputEmail.text!.isEmpty || !inputPassword.text!.isEmpty {
            
            loginError = false
            errorMessage = "You can't login because:"
            
            if !inputEmail.text!.contains("@") {
                errorMessage += "\n\u{2022} Email is not valid"
                loginError = true
            }
            if inputPassword.text!.count < 8 {
                errorMessage += "\n\u{2022} Password is less than 8 characters"
                loginError = true
            }
            
            if loginError {
                
                let alert = UIAlertController(title: "Warning!", message: errorMessage, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                let email = inputEmail.text!
                let password = inputPassword.text!
                
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    
                    if error != nil {
                        
                        errorMessage = error!.localizedDescription
                        
                        let alert = UIAlertController(title: "Warning!", message: errorMessage, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                        
                    } else {
                        
                        let homeView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AuthInitial")
                        
                        self.view.window?.rootViewController = homeView
                        self.view.window?.makeKeyAndVisible()
                        
                    }
                    
                }
                
            }
            
        } else {
            
            errorMessage = "Text field can't be empty!"
            
            let alert = UIAlertController(title: "Warning!", message: errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
}
