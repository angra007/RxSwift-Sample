//
//  Product.swift
//  ShopifySample
//
//  Created by Ankit Angra on 14/09/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation


class Products {
    var products = [Product] ()
    init?(products : JSONDictionary) {
        if let data = products ["products"] as? [JSONDictionary] {
            for product in data {
                let product = Product.init(data: product)
                self.products.append(product)
            }
        }
        else {
            return nil
        }
    }
}


class Product {
    var tags : String?
    init(data : JSONDictionary) {
        self.tags = data ["tags"] as? String
    }
}
