//
//  SettingsVC.swift
//  Tarifim
//
//  Created by Şenol Mert Duman on 30.05.2023.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutClicked(_ sender: Any) {
        let alertC = UIAlertController(title: "Tarifim", message: "Çıkış yapmak istediğinize emin misiniz?", preferredStyle: UIAlertController.Style.actionSheet)
        let hayirButton = UIAlertAction(title: "HAYIR", style: UIAlertAction.Style.cancel)
        alertC.addAction(hayirButton)
        let evetButton = UIAlertAction(title: "EVET", style: UIAlertAction.Style.default){ action in
            do {
                    try Auth.auth().signOut()
                    self.performSegue(withIdentifier: "toLoginVC", sender: nil)
                    } catch {
                        self.makeAlert(title: "ERROR", message: "error")
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
