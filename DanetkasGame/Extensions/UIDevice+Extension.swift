//
//  UIDevice+Extension.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 05/11/2021.
//

import UIKit


extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .compactMap({$0 as? UIWindowScene})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
            let bottom = keyWindow?.safeAreaInsets.bottom ?? 0
            return bottom > 0
        } else {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            return bottom > 0
        }
    }
}

extension UIWindow {
    
    func safeArea() -> CGSize {
        let keyWindow: UIWindow?
        if #available(iOS 11.0, *) {
            keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .compactMap({$0 as? UIWindowScene})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
        } else {
            keyWindow = UIApplication.shared.keyWindow
        }
        
        let insets = keyWindow?.rootViewController?.view.safeAreaInsets
        let safeAreaHeight = (keyWindow?.rootViewController?.view.frame.height ?? 0) - ((insets?.bottom ?? 0) + (insets?.top ?? 0))
        let safeAreaWidth  = (keyWindow?.rootViewController?.view.frame.width ?? 0) - ((insets?.left ?? 0) + (insets?.right ?? 0))
        
        return CGSize(width: safeAreaWidth,height: safeAreaHeight)
    }
    
}
