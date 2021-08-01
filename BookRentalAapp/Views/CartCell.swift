//
//  CartCell.swift
//  BookRentalAapp
//
//  Created by Eliel Vipata on 7/28/21.
//

import UIKit
import Parse

class CartCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var returnByLabel: UILabel!
    var book:Book?
    var object:PFObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteButton(_ sender: Any) {
        object?.deleteInBackground(block: { (success, error) in
            if error == nil {
                let userDefaults = UserDefaults.standard
                let total = userDefaults.integer(forKey: "cart_total")
                userDefaults.setValue(total-1, forKey: "cart_total")
                print("Successfully removed from cart")
            }else{
                print("couldn't find object")
            }
        })
    }
    
}
