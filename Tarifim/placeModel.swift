import Foundation
import UIKit

class PlaceModel{
    static let sharedInstance = PlaceModel()
    var mealName = ""
    var mealRecipe = ""
    var mealImageUrl = ""
    
    private init(){}
}
