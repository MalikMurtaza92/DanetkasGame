//
//  CreditCardViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 25/10/2021.
//

import UIKit

class CreditCardViewController: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet var textfieldViews: [UIView]!
    @IBOutlet weak var payButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        textfieldViews.forEach { view in
            view.layer.borderColor = Constant.blue.cgColor
            view.layer.borderWidth = 0.5
            view.subviews.forEach { subView in
                if let txtField = subView as? UITextField {
                    txtField.delegate = self
                }
            }
        }
        
        payButton.layer.cornerRadius = payButton.frame.size.height / 2
        payButton.dropShadow()
    }

}

//MARK:- TEXTFIELD DELEGATE
extension CreditCardViewController: UITextFieldDelegate {
    
}
