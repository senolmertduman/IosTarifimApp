//
//  TariflerVC.swift
//  Tarifim
//
//  Created by Şenol Mert Duman on 30.05.2023.
//

import UIKit
import Firebase
import SDWebImage


class TariflerVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var mealNameArray = [String]()
    var mealRecipeArray = [String]()
    var mealImageUrlArray = [String]()
    var mealDocumentIdArray = [String]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFirestore()

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mealNameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        cell.mealNameText.text = mealNameArray[indexPath.row]
        cell.mealImageView.sd_setImage(with: URL(string: mealImageUrlArray[indexPath.row]))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PlaceModel.sharedInstance.mealName = mealNameArray[indexPath.row]
        PlaceModel.sharedInstance.mealRecipe = mealRecipeArray[indexPath.row]
        PlaceModel.sharedInstance.mealImageUrl = mealImageUrlArray[indexPath.row]
        self.performSegue(withIdentifier: "toMealVC", sender: nil)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { (contextualAction, view, boolValue) in
            let firestoreDatabase = Firestore.firestore()
            firestoreDatabase.collection("Tarifler").document(self.mealDocumentIdArray[indexPath.row]).delete { error in
                if error != nil {
                    print(error?.localizedDescription ?? "error")
                }else{
                    print("successfully removed")
                }
            }
            self.tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    func getDataFromFirestore(){
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Tarifler").order(by: "date",descending: true).addSnapshotListener { snapshot, error in
            if error != nil{
                print("error")
            }else {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.mealNameArray.removeAll(keepingCapacity: false)
                    self.mealRecipeArray.removeAll(keepingCapacity: false)
                    self.mealImageUrlArray.removeAll(keepingCapacity: false)
                    self.mealDocumentIdArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        if let mealName = document.get("mealName") as? String{
                            self.mealNameArray.append(mealName)
                        }
                        if let mealRecipe = document.get("mealRecipe") as? String{
                            self.mealRecipeArray.append(mealRecipe)
                        }
                        if let mealImageUrl = document.get("mealImageUrl") as? String{
                            self.mealImageUrlArray.append(mealImageUrl)
                        }
                        let documentId = document.documentID
                        self.mealDocumentIdArray.append(documentId)
                        
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

}
