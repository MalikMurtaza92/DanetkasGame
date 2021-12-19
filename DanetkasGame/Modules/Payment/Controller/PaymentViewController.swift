//
//  PaymentViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 25/10/2021.
//

import UIKit

class PaymentViewController: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet var buttonViews: [UIView]!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonViews.forEach { view in
            view.dropShadow()
            if view.tag == 4 {
                view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.48).cgColor
                view.layer.borderWidth = 0.5
            }
            view.layer.cornerRadius = view.frame.size.height / 2
        }
    }
    
    func setupUI() {
        
    }
    
    @IBAction func payButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let VC = DanetkasHelper.getViewController(storyboard: .Payment, identifier: .CreditCardVC)
            self.present(to: VC, completion: nil)
        default:
            break
        }
    }

}
