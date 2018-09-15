//
//  ProductListTableViewCell.swift
//  ShopifySample
//
//  Created by Ankit Angra on 14/09/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {

    private var varient : Variants!
    
    class var reuseIdentifier : String {
        get {
            return "ProductListTableViewCell"
        }
    }
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var inventoryQuantityLabel: UILabel!
    
    func bind (withVarient varient: Variants) {
        self.varient = varient
        self.productTitleLabel.text = self.varient.title
        self.inventoryQuantityLabel.text = "\(self.varient.inventory_quantity)"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
