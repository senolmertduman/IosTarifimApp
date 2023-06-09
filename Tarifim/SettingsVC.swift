import UIKit
import Firebase

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
// to log out
    @IBAction func logoutClicked(_ sender: Any) {
        let alertC = UIAlertController(title: "Tarifim", message: "Are you sure you want to log out?", preferredStyle: UIAlertController.Style.actionSheet)
        let hayirButton = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel)
        alertC.addAction(hayirButton)
        let evetButton = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default){ action in
            do {
                    try Auth.auth().signOut()
                    self.performSegue(withIdentifier: "toLoginVC", sender: nil)
                    } catch {
                        self.makeAlert(title: "Error", message: "Could not log out")
                    }
        }
        alertC.addAction(evetButton)
        self.present(alertC, animated: true)
    }
    
    func makeAlert(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
