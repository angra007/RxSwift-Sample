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
    
    private var datasource : Products!
    var datasourceObserver = BehaviorRelay<[Product]>(value: [])
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
                    self.datasourceObserver.accept(data.products)
                }
                else {
                    let error = NSError.init(domain: ErrorMessage.genericMessage.rawValue, code: 500, userInfo: nil)
                    self.publishSubject.onError(error)
                }
            }
            
        }
    }
}
