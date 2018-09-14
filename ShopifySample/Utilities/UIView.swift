//
//  UIView.swift
//  meeApp
//
//  Created by Ankit Angra on 14/09/18.
//  Copyright © 2018 CoderScoop. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

class CellView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundCorners([.topRight, .bottomLeft], radius: 10)
    }
}

protocol XibDesignable : class {}

extension XibDesignable where Self : UIView {
    
    static func instantiateFromXib() -> Self {
        
        let dynamicMetatype = Self.self
        let bundle = Bundle(for: dynamicMetatype)
        let nib = UINib(nibName: "\(dynamicMetatype)", bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            
            fatalError("Could not load view from nib file.")
        }
        return view
    }
}

class GradientView: UIView {
    
    override open class var layerClass: AnyClass {
        get{
            return CAGradientLayer.classForCoder()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = self.layer as! CAGradientLayer
        let color1 = UIColor.white.withAlphaComponent(0.1).cgColor as CGColor
        let color2 = UIColor.white.withAlphaComponent(0.9).cgColor as CGColor
        gradientLayer.locations = [0.60, 1.0]
        gradientLayer.colors = [color2, color1]
    }
}
