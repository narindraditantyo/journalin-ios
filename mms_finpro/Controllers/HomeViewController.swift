
import UIKit
import Firebase
import FirebaseFirestore

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var arrJournal = [Journal]()
    var journalCollectionRef: CollectionReference!
    
    @IBOutlet weak var journalTV: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Home"
        
        journalTV.delegate = self
        journalTV.dataSource = self
        
//        journalCollectionRef = Firestore.firestore().collection(JOUR)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        journalCollectionRef.getDocuments { (snapshot, error) in
            
            if error != nil {
                debugPrint("Error fetching data: \(error)")
            } else {
                
                for document in (snapshot?.documents)! {
                    
                    let data = document.data()
                    
                    let date = data["date"]
                    let feeling = data["feeling"]
                    let desc = data["description"]
                    
                    let newJournal = Journal(date: date as! String, feeling: feeling as! String, description: desc as! String)
                    self.arrJournal.append(newJournal)
                    
                }
                
                self.journalTV.reloadData()
                
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrJournal.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as? JournalTableViewCell {
            
            
            return cell
            
        } else {
            return UITableViewCell()
        }
        
    }

    @IBAction func addJournal(_ sender: Any) {
        
        let addView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AddEditView")
        self.navigationController?.pushViewController(addView, animated: true)
        
    }
}
