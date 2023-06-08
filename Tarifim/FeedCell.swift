//
//  FeedCell.swift
//  Tarifim
//
//  Created by Şenol Mert Duman on 30.05.2023.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var mealNameText: UILabel!
    
    @IBOutlet weak var mealImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
