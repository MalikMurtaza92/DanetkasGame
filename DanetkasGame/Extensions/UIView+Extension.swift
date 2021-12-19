//
//  UIView+Extension.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 21/08/2021.
//

import UIKit
import SDWebImage

extension UIView{
    
    //DROP SHADOW WITH STANDARD STYLE
    func dropShadow(){
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.8
    }
}


extension UIImageView {
    
    func loadImage(with url: String) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "noImage"))
    }
    
}
