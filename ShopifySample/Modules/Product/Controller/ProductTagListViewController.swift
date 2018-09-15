//
//  ProductListViewController.swift
//  ShopifySample
//
//  Created by Ankit Angra on 14/09/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductTagListViewController: ParentViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var productViewModel : ProductViewModel = ProductViewModel ()
    
    private let disposeBag = DisposeBag ()
    
    private func setupTableView () {
        productViewModel.tagDatasourceObserver.asObservable().bind(to: tableView.rx.items(cellIdentifier: ProductTagTableViewCell.resueIdentifier)) {
            _, item, cell in
            if let cellToUse = cell as? ProductTagTableViewCell {
                cellToUse.productTag.text = item
                cellToUse.accessoryType = .disclosureIndicator
            }
            }.disposed(by: disposeBag)
        
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] indexPath in
                let productDetail = UIStoryboard.initViewController(withIdentifier: .productDetail) as! ProductListViewController
                productDetail.productViewModel = self.productViewModel
                productDetail.tag = self.productViewModel.getTag(atIndex: indexPath.row)
                self.navigationController?.pushViewController(productDetail, animated: true)
            })
            .disposed(by: disposeBag)

    }
    
    private func setupObservers () {
        productViewModel.publishSubject.subscribe(onNext: { (state) in
            switch state {
            case .downloadStarted :
                ActivityIndicatorManager.showActivityIndicator(inView: self.view)
            case .downloadFinished:
                ActivityIndicatorManager.dismissActivityIndicator(inView: self.view)
            }
        }, onError: { (error) in
            AlertManager.showAlert(inViewController: self, withTitle: "", message: error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers ()
        setupTableView ()
        productViewModel.getProducts()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
}

