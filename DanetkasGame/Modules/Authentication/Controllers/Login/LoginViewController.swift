//
//  LoginViewController.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 21/08/2021.
//

import UIKit
import MBProgressHUD
import FBSDKCoreKit
import FBSDKLoginKit
import AuthenticationServices

class LoginViewController: BaseViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginWithApple: UIView!
    @IBOutlet weak var loginWithFacebook: UIView!
    @IBOutlet weak var loginWithGoogle: UIView!
    
    //MARK:- PROPERTIES
    lazy var viewModel: LoginViewModel = {
        return LoginViewModel(viewController: self)
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
        
        loginButton.layer.cornerRadius = loginButton.frame.size.height / 2
        loginWithApple.layer.cornerRadius = loginWithApple.frame.size.height / 2
        loginWithFacebook.layer.cornerRadius = loginWithFacebook.frame.size.height / 2
        loginWithGoogle.layer.cornerRadius = loginWithGoogle.frame.size.height / 2
        
        loginButton.dropShadow()
        loginWithApple.dropShadow()
        loginWithGoogle.dropShadow()
        loginWithFacebook.dropShadow()
        
        NotificationCenter.default.addObserver(
            forName: .AccessTokenDidChange,
            object: nil,
            queue: .main
        ) { notification in
            if notification.userInfo?[AccessTokenDidChangeUserIDKey] != nil {
                // Handle user change
                print(notification)
            }
        }
        
    }

    //MARK:- IBACTIONS
    @IBAction func registerButtonTouch(_ sender: UIButton) {
        
        let signupVC = DanetkasHelper.getViewController(storyboard: .Authentication, identifier: .SignupVC)
        self.present(to: signupVC, completion: nil)
        
    }
    
    //MARK: - LOGIN WITH APPLE
    @IBAction func loginWithAppleButtonTouch(_ sender: UIButton) {
        handleAuthorizationAppleIDButtonPress()
    }
    
    
    //MARK: - LOGIN WITH FACEBOOK
    @IBAction func loginWithFacebookButtonTouch(_ sender: UIButton) {
        viewModel.loginWithFacebook { loginResult in
            self.hideProgress()
            if (loginResult?.isCancelled ?? false){
                print("Cancled")
            } else {
                print("notCancled")
            }
        }
    }
    
    //MARK: - LOGIN WITH GOOGLE
    @IBAction func loginWithGoogleButtonTouch(_ sender: UIButton) {
        viewModel.loginWithGoogle { user in
            Utility.shared.user = user

            let params = ["email": Utility.shared.user?.email ?? "",
                          "userType":"social"]
            self.viewModel.registerUser(parameters: params) { registeredUser, error in
                
                Endpoint.authToken = registeredUser?.user?.accessToken
                Utility.shared.user?.isProfileSet = registeredUser?.user?.isProfileSet
                if error == nil {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    if !(Utility.shared.user?.isProfileSet ?? false) {
                        let VC = DanetkasHelper.getViewController(storyboard: .Profile, identifier: .ProfileVC)
                        self.present(to: VC, completion: nil)
                    } else {
                        self.pop(completion: nil)
                    }
                } else {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.showSimpleAlert(title: Constant.title, message: error)
                }
            }
        }
    }
    
    //MARK:- LOGIN USER
    @IBAction func loginUser(_ sender: UIButton) {
        
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
        
        let params = ["email":emailTextField.text ?? "",
                      "password":passwordTextField.text ?? "",
                      "userType":"normal"]
        
        showProgress()
        viewModel.loginUser(parameters: params) { user, error in
            self.hideProgress()
            if error == nil {
                Endpoint.authToken = self.viewModel.loginUser?.accessToken
                Utility.shared.user = self.viewModel.loginUser
                if !(Utility.shared.user?.isProfileSet ?? false) {
                    let VC = DanetkasHelper.getViewController(storyboard: .Profile, identifier: .ProfileVC)
                    self.present(to: VC, completion: nil)
                } else {
                    self.pop(completion: nil)
                }
            } else {
                self.showSimpleAlert(title: Constant.title, message: error?.localizedDescription ?? "")
            }
        }
    }
    
    
    //
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    /// - Tag: perform_appleid_request
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}


extension LoginViewController: ASAuthorizationControllerDelegate {
    /// - Tag: did_complete_authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
            self.saveUserInKeychain(userIdentifier)
            
            print(userIdentifier,fullName,email)
            
            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
            self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
        
        case let passwordCredential as ASPasswordCredential:
        
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                self.showPasswordCredentialAlert(username: username, password: password)
            }
            
        default:
            break
        }
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "com.example.apple-samplecode.juice", account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
    
    private func showResultViewController(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
//        guard let viewController = self.presentingViewController as? ResultViewController
//            else { return }
//
//        DispatchQueue.main.async {
//            viewController.userIdentifierLabel.text = userIdentifier
//            if let givenName = fullName?.givenName {
//                viewController.givenNameLabel.text = givenName
//            }
//            if let familyName = fullName?.familyName {
//                viewController.familyNameLabel.text = familyName
//            }
//            if let email = email {
//                viewController.emailLabel.text = email
//            }
//            self.dismiss(animated: true, completion: nil)
//        }
    }
    
    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// - Tag: did_complete_error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

//MARK: - LOGIN WITH APPLE
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding{
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}



