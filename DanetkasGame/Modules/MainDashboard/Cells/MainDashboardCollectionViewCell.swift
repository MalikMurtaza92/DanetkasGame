//
//  MainDashboardCollectionViewCell.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 22/08/2021.
//

import UIKit

class OptionsCollectionViewCell: UICollectionViewCell {
    
    //MARK:- OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    
    class var identifier: String {
        return "OptionsCell"
    }
    
    var isScalingFactor: Bool = false{
        didSet {
            if isScalingFactor {
                if (UIScreen.main.bounds.height != 926.0)
                {
                    let scaleFactor: Float = Float(UIScreen.main.bounds.height) / 926.0
                    let fontSize = CGFloat(62.0 * scaleFactor)
                    self.titleLabel.font = self.titleLabel.font.withSize(fontSize)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
}
