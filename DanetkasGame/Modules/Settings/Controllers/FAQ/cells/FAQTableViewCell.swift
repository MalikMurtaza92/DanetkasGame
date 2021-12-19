//
//  FAQTableViewCell.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 21/10/2021.
//

import UIKit

protocol FAQTableViewCellDelegate {
    
    func expendQuestion(cell: UITableViewCell,indexPath: IndexPath)
}

class FAQTableViewCell: UITableViewCell {

    //MARK:- OUTLETS
    @IBOutlet weak var questionLabel: UILabel!
    
    //MARK:- PROPERTIES
    var delegate: FAQTableViewCellDelegate?
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    @IBAction func expendButton(_ sender: UIButton) {
        delegate?.expendQuestion(cell: self, indexPath: indexPath)
    }

}
