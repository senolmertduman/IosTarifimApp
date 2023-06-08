//
//  MealVC.swift
//  Tarifim
//
//  Created by Şenol Mert Duman on 30.05.2023.
//

import UIKit
import SDWebImage

class MealVC: UIViewController {
    @IBOutlet weak var mealRecipeText: UILabel!
    @IBOutlet weak var mealImageView: UIImageView!
    var mealName = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        mealImageView.sd_setImage(with: URL(string: PlaceModel.sharedInstance.mealImageUrl))
        mealName = PlaceModel.sharedInstance.mealName
        mealRecipeText.text = PlaceModel.sharedInstance.mealRecipe
        self.navigationItem.title = mealName //navigasyon barinin basligini ayarladik
    }
    


}
