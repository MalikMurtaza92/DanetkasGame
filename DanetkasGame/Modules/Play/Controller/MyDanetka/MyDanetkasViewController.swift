//
//  MyDanetkasViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 22/10/2021.
//

import UIKit

class MyDanetkasViewController: BaseViewController {
    
    //MARK:- OUTLETS
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var masterView: UIView!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var seeNowView: UIView!
    @IBOutlet weak var bundleView: UIView!
    @IBOutlet weak var buyNowView: UIView!

    var isFromMyDanetkas: Bool?
    var danetka: Danetka?
    
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
        
        if (isFromMyDanetkas ?? false) {
            bundleView.isHidden = true
            buyNowView.isHidden = true
            seeNowView.isHidden = false
            if let danetka = self.danetka {
                questionImageView.loadImage(with: "\(Endpoint.baseURLImage)\(danetka.image ?? "")")
                questionLabel.text = danetka.title ?? "Title Label"
                answerLabel.text = danetka.question ?? "Answer Label Answer Label Answer Label Answer Label Answer Label"
            }
        } else {
            bundleView.isHidden = false
            buyNowView.isHidden = false
            seeNowView.isHidden = true
            if let danetka = self.danetka {
                questionImageView.loadImage(with: "\(Endpoint.baseURLImage)\(danetka.image ?? "")")
                questionLabel.text = danetka.title ?? "Title Label"
                answerLabel.text = danetka.question ?? "Answer Label Answer Label Answer Label Answer Label Answer Label"
            }
        }
        

        //answerLabel.text = danetkas
    }
    
    @IBAction func actionButtonsPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            masterView.isHidden = false
        case 2:
            let VC = DanetkasHelper.getViewController(storyboard: .Payment, identifier: .PaymentVC)
            self.present(to: VC, completion: nil)
        case 3:
            let VC = DanetkasHelper.getViewController(storyboard: .Payment, identifier: .BundleDiscountVC)
            self.present(to: VC, completion: nil)
        default:
            break
        }
    }
    
    @IBAction func masterButton(_ sender: UIButton) {
        masterView.isHidden = true
        let VC = DanetkasHelper.getViewController(storyboard: .Play, identifier: .AnswerVC) as! AnswerDanetkasViewController
        VC.danetka = self.danetka
        self.present(to: VC, completion: nil)
    }

}
