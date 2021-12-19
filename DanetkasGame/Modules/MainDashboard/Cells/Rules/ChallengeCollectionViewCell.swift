//
//  ChallengeCollectionViewCell.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 15/11/2021.
//

import UIKit

class ChallengeCollectionViewCell: RulesSuperCollectionViewCell {
    
    class var  nibName: String {
        "ChallengeCollectionViewCell"
    }
    class var Identifier: String {
        "ChallengeCollectionViewCell"
    }

    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.cornerRadius = 25
    }

}


