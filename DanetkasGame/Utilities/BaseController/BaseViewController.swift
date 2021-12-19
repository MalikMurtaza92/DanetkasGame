//
//  BaseViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 01/11/2021.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dismissScreen(_ sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func popToRootController(_ sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func hideProgress() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func showProgress() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
}
