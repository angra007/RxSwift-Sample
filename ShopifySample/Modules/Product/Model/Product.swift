//
//  Product.swift
//  ShopifySample
//
//  Created by Ankit Angra on 14/09/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation


class Products {
    var items = [Product] ()
    init?(products : JSONDictionary) {
        if let data = products ["products"] as? [JSONDictionary] {
            for product in data {
                let product = Product.init(data: product)
                self.items.append(product)
            }
        }
        else {
            return nil
        }
    }
}


class Product {
    var tags : String?
    var title : String?
    var variants = [Variants] ()
    init(data : JSONDictionary) {
        self.tags = data ["tags"] as? String
        self.title = data ["title"] as? String
        if let data = data ["variants"] as? [JSONDictionary] {
            for product in data {
                let product = Variants.init(data: product)
                self.variants.append(product)
            }
        }
    }
}


class Variants {
    var title : String?
    var inventory_quantity : Int = 0
    init(data : JSONDictionary) {
        self.title = data ["title"] as? String
        if let quantity = data ["inventory_quantity"] as? Int {
            self.inventory_quantity = quantity
        }
    }
}




