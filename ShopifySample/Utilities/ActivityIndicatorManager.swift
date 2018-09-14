//
//  ActivityIndicatorManager.swift
//  phostagram-ios
//
//  Created by Ankit Angra on 27/09/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class ActivityIndicatorManager {
    
    
    static let Activity_Indicator_Tag = 10002
    
    class func showActivityIndicator (inView view : UIView) {
        DispatchQueue.main.async {
            let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            activityView.tag = Activity_Indicator_Tag
            activityView.center = view.center
            activityView.hidesWhenStopped = true
            activityView.startAnimating()
            view.addSubview(activityView)
        }
    }
    
    class func dismissActivityIndicator (inView view : UIView) {
        DispatchQueue.main.async {
            if let activityView = view.viewWithTag(Activity_Indicator_Tag) as? UIActivityIndicatorView {
                activityView.stopAnimating ()
            }
        }
    }
    
}
