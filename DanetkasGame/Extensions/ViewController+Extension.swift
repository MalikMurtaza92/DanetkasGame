//
//  ViewController+Extension.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 21/08/2021.
//

import UIKit


extension UIViewController {
    
    func present(to toVC: UIViewController, completion: (() -> Void)?) {
        if self.navigationController != nil {
            self.navigationController?.pushViewController(toVC, animated: true)
        } else {
            self.present(toVC, animated: true, completion: completion)
        }
    }
    
    func pop(completion: (() -> Void)?){
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: completion)
        }
    }
    
    func popToRoot(){
        if self.navigationController != nil {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    func showSimpleAlert(title: String?, message: String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showToastAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func showAlertWithOk(title: String?, message: String?,handler: alertHandler){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
    
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

