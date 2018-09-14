//
//  File.swift
//  Sloggers
//
//  Created by Ankit Angra on 05/02/17.
//  Copyright © 2017 NewMediaTechies. All rights reserved.
//

import UIKit

extension UIStoryboard {
    enum StoryboardIdentifiers : String {
        
        // Authentication
        case productList = "ProductListVC"
        case productDetail = "ProductDetailVC"
        
        
        var storyboard : UIStoryboard {
            
            switch self {
            case .productList:
                return productStoryboard ()
            
            case .productDetail:
                return productStoryboard ()
            }
            
        }
        
    }
    
    private class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func productStoryboard () -> UIStoryboard {
        return  UIStoryboard(name: "ProductStoryboard", bundle: Bundle.main)
    }
    
    class func initViewController (withIdentifier identifier : StoryboardIdentifiers) -> UIViewController {
        return identifier.storyboard.instantiateViewController(withIdentifier: identifier.rawValue)
    }
    
}
