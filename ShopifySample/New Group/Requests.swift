//
//  URL.swift
//  ShopifySample
//
//  Created by Ankit Angra on 14/09/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation

enum RequestType {
    case productList

    var url : String {
        switch self {
        case .productList:
            return "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        }
    }
}
