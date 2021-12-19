//
//  MakeMyDanetkaCollectionViewCell.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 21/10/2021.
//

import UIKit

class MakeMyDanetkaCollectionViewCell: UICollectionViewCell {
    
    //MARK:- OUTLETS
    @IBOutlet var viewForTextView: [UIView]!
    @IBOutlet var inserButtonView: [UIView]!
    @IBOutlet var textView: [UITextView]!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var indicatorView: UIView!
    
    //MARK:- PROPERTIES
    class var identifier: String {
        return "MakeMyDanetkaCollectionViewCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        textView.forEach { textView in
            textView.text = "Type here..."
            textView.delegate = self
            textView.textColor = UIColor.black.withAlphaComponent(0.25)
        }
        searchView.layer.cornerRadius = searchView.frame.size.height / 2
        searchView.layer.borderColor = UIColor(hex: "#E8E8E8").cgColor
        searchView.layer.borderWidth = 1.0
        
        viewForTextView.forEach { view in
            view.layer.cornerRadius = 20.0
            view.layer.borderColor = UIColor(red: 227/255, green: 227/255, blue: 231/255, alpha: 1).cgColor
            view.layer.borderWidth = 1.0
        }
        
        inserButtonView.forEach { view in
            view.dropShadow()
            view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.48).cgColor
            view.layer.borderWidth = 0.5
            view.layer.cornerRadius = view.frame.size.height / 2
        }
        
        submitButton.layer.cornerRadius = submitButton.frame.size.height / 2
        indicatorView.layer.cornerRadius = indicatorView.frame.height / 2
    }

}

//TEXTVIEW DELEGATE
extension MakeMyDanetkaCollectionViewCell: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.black.withAlphaComponent(0.25) {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type here..."
            textView.textColor = UIColor.black.withAlphaComponent(0.25)
        }
    }
}
