//
//  AnswerDanetkasViewController.swift
//  DanetkasGame
//
//  Created by Murtaza Mehmood on 24/12/2021.
//

import UIKit

class AnswerDanetkasViewController: BaseViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerImage: UIImageView!
    
    @IBOutlet weak var learnMoreButton: UIButton!

    var danetka: Danetka?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        learnMoreButton.layer.cornerRadius = learnMoreButton.frame.size.height / 2
        learnMoreButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        learnMoreButton.layer.borderWidth = 0.5
        learnMoreButton.dropShadow()
    }
    
    func setupUI(){
        addHints()
        titleLabel.text = self.danetka?.title ?? ""
        answerLabel.text = self.danetka?.answer ?? "null"
        //answerImage.loadImage(with: self.danetka?.image)
        answerImage.loadImage(with: "\(Endpoint.baseURLImage)\(danetka?.image ?? "")")
    }
    
    @IBAction func learnMoreButton(_ sender: UIButton) {
        let VC = DanetkasHelper.getViewController(storyboard: .Play, identifier: .LearnMoreVC) as! LearnMoreViewController
        VC.danetka = self.danetka
        self.present(to: VC, completion: nil)
    }
    
    
    func addHints() {
        if let hints = danetka?.hint?.components(separatedBy: ",") {
            for hint in hints {
                let hintView = UIView()
                hintView.backgroundColor = .clear
                hintView.translatesAutoresizingMaskIntoConstraints = false
                
                let image = UIImageView()
                image.translatesAutoresizingMaskIntoConstraints = false
                
                hintView.addSubview(image)
                image.leadingAnchor.constraint(equalTo: hintView.leadingAnchor, constant: 8).isActive = true
                image.centerYAnchor.constraint(equalTo: hintView.centerYAnchor, constant: 0).isActive = true
                image.heightAnchor.constraint(equalToConstant: 25).isActive = true
                image.addConstraint(NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: image, attribute: .width, multiplier: 1, constant: 0))
                image.image = UIImage(named: "rigoletto")
                
                let hintLabel = UILabel()
                hintLabel.translatesAutoresizingMaskIntoConstraints = false
                hintLabel.numberOfLines = 0
                hintLabel.font = UIFont(name: "Poppins-Regular", size: 12)
                hintLabel.text = hint
                hintLabel.textColor = UIColor(red: 26/255, green: 88/255, blue: 118/255, alpha: 1)
                
                hintView.addSubview(hintLabel)
                hintLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8).isActive = true
                hintLabel.trailingAnchor.constraint(equalTo: hintView.trailingAnchor, constant: -8).isActive = true
                hintLabel.topAnchor.constraint(equalTo: hintView.topAnchor, constant: 8).isActive = true
                hintLabel.bottomAnchor.constraint(equalTo: hintView.bottomAnchor, constant: -8).isActive = true
                
                scrollStackView.addArrangedSubview(hintView)
                hintView.heightAnchor.constraint(equalToConstant: hint.height(withConstrainedWidth: (self.view.frame.width - 52) - (50 - 24), font: UIFont(name: "Poppins-Regular", size: 12)!) + 16).isActive = true
            }
        }
    }

}
  
