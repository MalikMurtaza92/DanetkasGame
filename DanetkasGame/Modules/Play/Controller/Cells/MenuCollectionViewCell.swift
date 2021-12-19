//
//  MenuCollectionViewCell.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 25/08/2021.
//

import UIKit
class MenuCollectionViewCell: UICollectionViewCell {
    
    //MARK:- OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:- PROPERTIES
    class var identifier: String {
        return "MenuCell"
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
            titleLabel.transform =  CGAffineTransform(scaleX: 1.2, y: 1.2)
            } else {
                titleLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
}
