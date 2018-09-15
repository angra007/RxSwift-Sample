//
//  ProductViewModel.swift
//  ShopifySample
//
//  Created by Ankit Angra on 14/09/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


enum ProductState {
    case downloadStarted
    case downloadFinished
}

class ProductViewModel {
    
    private var products : Products!
    private var uniqueTags  = [String] ()
    private var productList = [Product] ()
    
    var tagDatasourceObserver = BehaviorRelay<[String]>(value: [])
    var productDatasourceObserver = BehaviorRelay<[Product]>(value: [])
    
    var publishSubject = PublishSubject<ProductState>()
    
    init() {
        self.getProducts()
    }
    
    func getProducts () {
        publishSubject.onNext(.downloadStarted)
        DownloadManager.get(url: RequestType.productList.url, parse: {  (data) -> AnyObject? in
            return Products.init(products: data)
        }) { [unowned self] (data, error) in
            self.publishSubject.onNext(.downloadFinished)
            if let error = error {
                self.publishSubject.onError(error)
            }
            else {
                if let data = data as? Products {
                    self.products = data
                    self.uniqueTags = self.getUniqueTag ()
                    self.tagDatasourceObserver.accept(self.uniqueTags)
                }
                else {
                    let error = NSError.init(domain: ErrorMessage.genericMessage.rawValue, code: 500, userInfo: nil)
                    self.publishSubject.onError(error)
                }
            }
            
        }
    }
    
    
    private func getUniqueTag () -> [String] {
        var tags = [String] ()
        for product in self.products.items {
            if tags.contains(product.tags!) == false {
                tags.append(product.tags!)
            }
        }
        return tags
    }
    
    func getTag (atIndex index : Int) -> String {
        return self.uniqueTags[index]
    }
    
    func productsForTag (atIndex index : Int) -> [Product] {
        let tag = self.uniqueTags [index]
        return filterProducts(withTag: tag)
    }
    
    func initilizeProductListDatasource (forTag tag : String) {
        self.productList = self.filterProducts(withTag: tag)
        self.productDatasourceObserver.accept(self.productList)
    }
    
    func productName (atIndex index : Int) -> String {
        return self.productList[index].title!
    }
    
    func getTotalAvailableInventory (forProduct product : Product) -> Int {
        var total = 0
        for varient in product.variants {
            total = total + varient.inventory_quantity
        }
        return total
    }
    
    private func filterProducts (withTag tag : String) -> [Product] {
        var selectedProducts = [Product] ()
        selectedProducts = products.items.filter({ (product) -> Bool in
            if product.tags == tag {
                return true
            }
            else {
                return false
            }
        })
        return selectedProducts
    }
    
    
}
