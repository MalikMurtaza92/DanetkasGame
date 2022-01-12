//
//  SignUpViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 21/08/2021.
//

import UIKit
import MBProgressHUD

class SignUpViewController: BaseViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cnfrmPasswordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signupWithApple: UIView!
    @IBOutlet weak var signupWithFacebook: UIView!
    @IBOutlet weak var signupWithGoogle: UIView!
    
    
    //MARK:- PROPERTIES
    //MARK:- PROPERTIES
    lazy var viewModel: SignupViewModel = {
        return SignupViewModel(viewController: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    //MARK:- SETUP UI
    fileprivate func setupUI(){
        
        registerButton.layer.cornerRadius = registerButton.frame.size.height / 2
        signupWithApple.layer.cornerRadius = signupWithApple.frame.size.height / 2
        signupWithFacebook.layer.cornerRadius = signupWithFacebook.frame.size.height / 2
        signupWithGoogle.layer.cornerRadius = signupWithGoogle.frame.size.height / 2
        
        registerButton.dropShadow()
        signupWithApple.dropShadow()
        signupWithFacebook.dropShadow()
        signupWithGoogle.dropShadow()
        
    }
    
    //MARK:- IBACTIONS
    
    @IBAction func playAsGuestButtonTouch(_ sender: UIButton) {
        Utility.shared.isPlayAsGuest = true
        self.popToRoot()
    }
    
    @IBAction func loginButtonTouch(_ sender: UIButton) {
        self.pop(completion: nil)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        guard emailTextField.text != "" && passwordTextField.text !=  "" else {
            self.showSimpleAlert(title: Constant.title, message: "Please Enter email and password.")
            return
        }
        
        guard emailTextField.text != "" else {
            self.showSimpleAlert(title: Constant.title, message: "Please Enter email.")
            return
        }
        
        guard passwordTextField.text != "" else {
            self.showSimpleAlert(title: Constant.title, message: "Please Enter Password.")
            return
        }
        
        guard cnfrmPasswordTextField.text != "" else {
            self.showSimpleAlert(title: Constant.title, message: "Please Enter Confirm Password.")
            return
        }
        
        guard cnfrmPasswordTextField.text == passwordTextField.text else {
            self.showSimpleAlert(title: Constant.title, message: "Passwords are not same")
            return
        }
        
        let params = ["email":emailTextField.text ?? "",
                      "password":passwordTextField.text ?? "",
                      "userType":"normal"]
        
        viewModel.registerUser(parameters: params) { response, error in
            
            if error == nil {
                if !(response?.user?.isProfileSet ?? false) {
                    Utility.shared.user?.email = response?.user?.email
                    Utility.shared.user?.isProfileSet = false
                    let VC = DanetkasHelper.getViewController(storyboard: .Profile, identifier: .ProfileVC)
                    self.present(to: VC, completion: nil)
                } else {
                    self.pop(completion: nil)
                }
            } else {
                self.showSimpleAlert(title: Constant.title, message: error)
            }
            
        }
    }
    
    
    @IBAction func registerGoogleButtonPressed(_ sender: UIButton) {
        viewModel.loginWithGoogle { user, error in
            if error == nil {
                if !(user?.user?.isProfileSet ?? false) {
                    Utility.shared.user?.email = user?.user?.email
                    Utility.shared.user?.isProfileSet = false
                    let VC = DanetkasHelper.getViewController(storyboard: .Profile, identifier: .ProfileVC)
                    self.present(to: VC, completion: nil)
                } else {
                    self.pop(completion: nil)
                }
            } else {
                self.showSimpleAlert(title: Constant.title, message: error)
            }
        }
    }
    
    
    @IBAction func registerFacebookButtonPressed(_ sender: UIButton) {
        viewModel.loginWithFacebook { user, error in
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    
}
