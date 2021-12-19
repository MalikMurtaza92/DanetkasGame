//
//  ContactViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 11/09/2021.
//

import UIKit
import MBProgressHUD

class ContactViewController: BaseViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var viewForTextView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var viewForEmailTextView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        submitButton.layer.cornerRadius = submitButton.frame.size.height / 2
    }
    
    fileprivate func setupUI() {
        viewForTextView.layer.cornerRadius = 20.0
        viewForTextView.layer.borderColor = UIColor(red: 227/255, green: 227/255, blue: 231/255, alpha: 1).cgColor
        viewForTextView.layer.borderWidth = 1.0
        
        viewForEmailTextView.layer.cornerRadius = viewForEmailTextView.frame.height / 2
        viewForEmailTextView.layer.borderColor = UIColor(red: 227/255, green: 227/255, blue: 231/255, alpha: 1).cgColor
        viewForEmailTextView.layer.borderWidth = 1.0
        
        emailTextField.placeholder = "Your email"
        
        textView.text = "Type here..."
        textView.delegate = self
        textView.textColor = UIColor.black.withAlphaComponent(0.25)
        
        
        submitButton.dropShadow()
        
        addressLabel.text = "Gerberstrasse 12,\n47798 Krefeld,\nDeutschland"
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        textView.resignFirstResponder()
        emailTextField.resignFirstResponder()
        if let email = emailTextField.text,let message = textView.text {
            if !email.isEmpty && !message.isEmpty {
                if email.isValidEmail() {
                    showProgress()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.hideProgress()
                        self.pop(completion: nil)
                    }
                } else {
                    showSimpleAlert(title: Constant.title, message: "Please enter valid email.")
                }
            }
            else {
                showSimpleAlert(title: Constant.title, message: "Please enter email and message.")
            }
            
        } else {
            showSimpleAlert(title: Constant.title, message: "Please enter email and message.")
        }
    }

}

//TEXTVIEW DELEGATE
extension ContactViewController: UITextViewDelegate {
    
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
