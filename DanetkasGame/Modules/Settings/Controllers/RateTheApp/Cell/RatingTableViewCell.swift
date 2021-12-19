//
//  RatingTableViewCell.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 28/08/2021.
//

import UIKit
import Cosmos
class RatingTableViewCell: UITableViewCell {
    
    //MARK:- OUTLETS
    @IBOutlet weak var ratingQuestionLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    //MARK:- PROPERTIES
    class var identifier: String {
        "RatingVC"
    }
    
    var ratings: RatingsModel? {
        didSet {
            ratingQuestionLabel.text = ratings?.question ?? ""
            ratingView.rating = ratings?.rating ?? 0.0
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        ratingView.didFinishTouchingCosmos = { (rating) in
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
