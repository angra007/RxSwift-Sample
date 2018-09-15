//
//  ProductListTableViewCell.swift
//  ShopifySample
//
//  Created by Ankit Angra on 14/09/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class ProductTagTableViewCell: UITableViewCell {

    
    class var resueIdentifier : String {
        get {
            return "ProductTagTableViewCell"
        }
    }
    
    @IBOutlet weak var productTag: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
