//
//  RulesSuperCollectionViewCell.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 22/11/2021.
//

import UIKit

protocol RulesDelegate {
    
    func selectRulesOption(index: Int)
    func dismissScreen()
    
}

class RulesSuperCollectionViewCell: UICollectionViewCell {
    
    var delegate: RulesDelegate?
    
    @IBAction func dismissScreen(_ sender: UIButton){
        delegate?.dismissScreen()
    }
    
    @IBAction func rulesScreen(_ sender: UIButton){
        delegate?.selectRulesOption(index: 0)
    }
    
    @IBAction func gamePlayScreen(_ sender: UIButton){
        delegate?.selectRulesOption(index: 1)
    }
    
    @IBAction func extraScreen(_ sender: UIButton){
        delegate?.selectRulesOption(index: 2)
    }
    
    @IBAction func challangeScreen(_ sender: UIButton){
        delegate?.selectRulesOption(index: 3)
    }
    
}
