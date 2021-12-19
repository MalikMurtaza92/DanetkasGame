//
//  DanetkasCollectionViewCell.swift
//  DanetkasGame
//
//  Created by Murtaza Mehmood on 12/12/2021.
//

import UIKit

class DanetkasCollectionViewCell: UICollectionViewCell {
    
    //MARK:- OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popularLabel: UILabel!
    @IBOutlet weak var descriptionButton: UIButton!
    @IBOutlet weak var danetkasImageView: UIImageView!
    
    //MARK:- PROPERTIES
    var indexPath: IndexPath?
    
    class var identifier: String {
        String(describing: self)
    }
    
    class var nib: UINib  {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var model: DanetkasCellViewModel? {
        didSet {
            titleLabel.text = model?.Danetkas?.name ?? ""
            danetkasImageView.loadImage(with: "\(Endpoint.baseURLImage)\(model?.Danetkas?.image ?? "")")
            self.indexPath = model?.indexPath
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        popularLabel.isHidden = true
        descriptionButton.isHidden = true
    }

}
