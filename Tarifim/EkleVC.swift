//
//  EkleVC.swift
//  Tarifim
//
//  Created by Şenol Mert Duman on 30.05.2023.
//

import UIKit
import Firebase

class EkleVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tarifText: UITextView!
    @IBOutlet weak var mealNameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        

    
    }
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("Media")
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data) { metadata, error in
                if error != nil {
                    print("error")
                }else{
                    imageReference.downloadURL { url, error in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            // database
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference : DocumentReference? = nil
                            let mealPosts = ["mealName":self.mealNameText.text!,"mealRecipe":self.tarifText.text!,"mealImageUrl":imageUrl!,"date":FieldValue.serverTimestamp()] as [String : Any]
                            firestoreReference = firestoreDatabase.collection("Tarifler").addDocument(data: mealPosts,completion: { error in
                                if error != nil{
                                    print("error")
                                }else{
                                    /*
                                     tab barda yeni bir sey eklendigini belirlemek icin etiket ekledik. Cok gerekli degil o yuzden sildim.
                                    if let tabBarItems = self.tabBarController?.tabBar.items{
                                        let tabBar = tabBarItems[0]
                                        tabBar.badgeValue = "New"
                                        tabBar.badgeColor = UIColor.red
                                    } */
                                    self.imageView.image = UIImage(named: "select")
                                    self.mealNameText.text = ""
                                    self.tarifText.text = ""
                                    //self.performSegue(withIdentifier: "toTariflerVC", sender: nil)
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            
                        }
                    }
                }
            }
        }
    }
    


}
