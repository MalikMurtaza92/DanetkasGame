//
//  LearnMoreViewController.swift
//  DanetkasGame
//
//  Created by Murtaza Mehmood on 24/12/2021.
//

import UIKit

class LearnMoreViewController: BaseViewController {
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerLabelView: UIView!
    var danetka: Danetka?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupUI(){
        answerLabelView.layer.cornerRadius = 10
        answerLabel.text = danetka?.learnMore ?? "null"
    }

}
