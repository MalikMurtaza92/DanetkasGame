//
//  GamePlayCollectionViewCell.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 15/11/2021.
//

import UIKit

protocol GamePlayDelegate {
    func falseButton()
    func specifyButton()
}

class GamePlayCollectionViewCell: RulesSuperCollectionViewCell {
    
    class var nibName: String {
        "GamePlayCollectionViewCell"
    }
    class var Identifier: String {
        "GamePlayCollectionViewCell"
    }
    
    var gamePlayDelegate: GamePlayDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func falseAssumptionButton(_ sender: UIButton) {
        gamePlayDelegate?.falseButton()
    }

    
    @IBAction func specifyButton(_ sender: UIButton) {
        gamePlayDelegate?.specifyButton()
    }
}


