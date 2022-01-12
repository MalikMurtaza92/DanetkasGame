//
//  MyDanetkasTableViewCell.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 25/08/2021.
//

import UIKit

class MyDanetkasTableViewCell: UITableViewCell {
    
    //MARK:- OUTLETS
    @IBOutlet weak var danetkaTitleLabel: UILabel!
    @IBOutlet weak var danetkaImageView: UIImageView!
    @IBOutlet weak var popularLabel: UILabel!
    @IBOutlet weak var listButton: UIButton!
    
    //MARK:- PROPERTIES
    class var identifier: String {
        "MyDanetkasTableViewCell"
    }
    
    var danetka: PlayViewModel.DanetkaModel? {
        didSet {
            self.danetkaTitleLabel.text = danetka?.title ?? ""
            self.danetkaImageView.loadImage(with: "\(Endpoint.baseURLImage)\(danetka?.image ?? "")")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
