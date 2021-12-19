//
//  MyDanetkasViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 22/10/2021.
//

import UIKit

class MyDanetkasViewController: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var masterView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        buttons.forEach { button in
            button.layer.cornerRadius = button.frame.size.height / 2
            button.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
            button.layer.borderWidth = 0.5
            if button.tag != 4 { button.dropShadow() }
        }
    }
    
    func setupUI() {
        masterView.isHidden = true
    }
    
    @IBAction func actionButtonsPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            masterView.isHidden = false
        case 2:
            let VC = DanetkasHelper.getViewController(storyboard: .Payment, identifier: .PaymentVC)
            self.present(to: VC, completion: nil)
        default:
            break
        }
    }
    
    @IBAction func masterButton(_ sender: UIButton) {
        masterView.isHidden = true
    }

}
