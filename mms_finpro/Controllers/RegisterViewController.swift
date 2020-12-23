
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {

    @IBOutlet weak var inputFullname: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputConfirmPass: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Register"
        registerButton.layer.cornerRadius = 5

    }

    @IBAction func processRegister(_ sender: Any) {
        
        var errorMessage: String = ""
        var registrationError: Bool = false
        
        if !inputFullname.text!.isEmpty || !inputEmail.text!.isEmpty || !inputPassword.text!.isEmpty || !inputConfirmPass.text!.isEmpty {
            
            registrationError = false
            errorMessage = "Your registration is invalid because:"
            
            if !inputEmail.text!.contains("@") {
                errorMessage += "\n\u{2022} Email is not valid"
                registrationError = true
            }
            if inputPassword.text!.count < 8 {
                errorMessage += "\n\u{2022} Password is less than 8 characters"
                registrationError = true
            }
            if inputPassword.text != inputConfirmPass.text {
                errorMessage += "\n\u{2022} Confirmation password didn't match"
                registrationError = true
            }
            
            if registrationError {
                
                let alert = UIAlertController(title: "Warning!", message: errorMessage, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                let fullname = inputFullname.text!
                let email = inputEmail.text!
                let password = inputPassword.text!
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    
                    if error != nil {
                        
                        errorMessage = error!.localizedDescription
                        
                        let alert = UIAlertController(title: "Warning!", message: errorMessage, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                        
                    } else {
                        
                        let db = Firestore.firestore()
                        
                        db.collection("users").addDocument(data: [
                            "uid": result!.user.uid,
                            "fullName": fullname,
                            "email": email
                        ])
                        
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
