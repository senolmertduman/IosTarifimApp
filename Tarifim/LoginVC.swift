import UIKit
import Firebase

class LoginVC: UIViewController {
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.isSecureTextEntry = true //to hide password
        
    }
// Sign in
    @IBAction func signInClicked(_ sender: Any) {
        if usernameText.text != "" && passwordText.text != ""{
            Auth.auth().signIn(withEmail: usernameText.text!, password: passwordText.text!) { authData, error in
                if error != nil{
                    self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "error")
                } else{
                    self.performSegue(withIdentifier: "toTariflerVC", sender: nil)
                }
            }
        } else{
            self.makeAlert(title: "ERROR", message: "Username/password?")
        }
    }
// Sign up
    @IBAction func signUpClicked(_ sender: Any) {
        if usernameText.text != "" && passwordText.text != ""{
            Auth.auth().createUser(withEmail: usernameText.text!, password: passwordText.text!) { authData, error in
                if error != nil{
                    self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "error")
                }else{
                    self.performSegue(withIdentifier: "toTariflerVC", sender: nil)
                }
            }
        } else {
            self.makeAlert(title: "ERROR", message: "Username/password?")
        }
    }
// Make alert function
    func makeAlert(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }

}

