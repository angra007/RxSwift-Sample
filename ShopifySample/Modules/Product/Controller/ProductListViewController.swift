//
//  ProductDetailViewController.swift
//  ShopifySample
//
//  Created by Ankit Angra on 14/09/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductListViewController: ParentViewController {

    var productViewModel : ProductViewModel!
    var tag : String!
    
    private let disposeBag = DisposeBag ()
    
    @IBOutlet weak var productListTableView: UITableView!
    
    
    private func setupTableView () {
        productViewModel.productDatasourceObserver.asObservable().bind(to: productListTableView.rx.items(cellIdentifier: ProductListTableViewCell.reuseIdentifier)) { [unowned self]
            _, item, cell in
            if let cellToUse = cell as? ProductListTableViewCell {
                cellToUse.productTitleLabel?.text = item.title
                cellToUse.inventoryQuantityLabel.text =  ("\(self.productViewModel.getTotalAvailableInventory(forProduct: item))  available")
            }
            }.disposed(by: disposeBag)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productViewModel.initilizeProductListDatasource(forTag: tag)
        setupTableView ()
        // Do any additional setup after loading the view.
    }

}
