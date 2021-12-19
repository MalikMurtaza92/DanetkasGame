//
//  DictionaryTableViewCell.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 27/08/2021.
//

import UIKit

class DictionaryTableViewCell: UITableViewCell {
    
    //MARK:- OUTELTS
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var meaningLabel: UILabel!
    
    //MARK:- PROPERTIES
    class var identifier: String {
        "DictionaryCell"
    }
    
    var word: Dictionary? {
        didSet {
            wordLabel.text = word?.word ?? ""
            if word?.isSelected ?? false {
                meaningLabel.text = word?.meaning ?? ""
                meaningLabel.isHidden = false
            } else {
                meaningLabel.isHidden = true
            }
            self.layoutIfNeeded()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

}
