
import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.layer.cornerRadius = 5
    }

    @IBAction func processLogout(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            
            let homeView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NoAuthInitial")
            
            self.view.window?.rootViewController = homeView
            self.view.window?.makeKeyAndVisible()
        } catch let error {
            print(error)
        }
        
    }
    
}
