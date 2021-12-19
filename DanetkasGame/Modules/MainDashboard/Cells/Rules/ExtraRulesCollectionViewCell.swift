//
//  ExtraRulesCollectionViewCell.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 15/11/2021.
//

import UIKit

class ExtraRulesCollectionViewCell: RulesSuperCollectionViewCell {
    
    class var nibName: String {
        "ExtraRulesCollectionViewCell"
    }
    class var Identifier: String {
        "ExtraRulesCollectionViewCell"
    }

    @IBOutlet var view:[UIView]!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.forEach{$0.layer.cornerRadius = 30}
    }

}
