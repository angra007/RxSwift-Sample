//
//  ViewController.swift
//  ShopifySample
//
//  Created by Ankit Angra on 12/09/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        DownloadManager.get(url: "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6", parse: { (data) -> AnyObject? in
            return nil
        }) { (data, nil) in
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

