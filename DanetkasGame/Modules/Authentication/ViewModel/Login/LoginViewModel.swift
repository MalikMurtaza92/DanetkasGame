//
//  LoginViewModel.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 21/08/2021.
//

import UIKit
import GoogleSignIn
import MBProgressHUD
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewModel {
    
    typealias loginCompletion = ((GameUser?,Error?)->Void)
    typealias registrationCompletion = ((RegisterDataResponse?,String?)->Void)
    
    private var viewController: UIViewController
    
    var loginUser: GameUser?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    //REGISTER USER
    func registerUser(parameters: Parameters,completionHandler: @escaping registrationCompletion) {
        
        
        MBProgressHUD.showAdded(to: self.viewController.view, animated: true)
        HTTPService.shared.postRequestWithoutHeader(endpoint: Endpoint.register, parameters: parameters, model: RegisterDataResponse.self) { response, error in
            MBProgressHUD.hide(for: self.viewController.view, animated: true)
            guard response != nil else {
                completionHandler(nil,error?.localizedDescription ?? "")
                return
            }
            
            if response?.code == 201 {
                completionHandler(response?.data,nil)
                
            } else if response?.code == 208 {
                if response?.data?.user?.userType == "social" {
                    let params = ["email":response?.data?.user?.email ?? "",
                                  "userType":"social"]
                    
                    self.loginUser(parameters: params) { user, error in
                        if error == nil {
                            completionHandler(RegisterDataResponse(user: user),nil)
                        } else {
                            completionHandler(nil,error?.localizedDescription ?? "")
                        }
                    }
                    
                } else {
                    self.loginUser(parameters: parameters) { user, error in
                        if error == nil {
                            completionHandler(RegisterDataResponse(user: user),nil)
                        } else {
                            completionHandler(nil,error?.localizedDescription ?? "")
                        }
                    }
                }
                completionHandler(response?.data,nil)
            } else {
                completionHandler(nil,error?.localizedDescription ?? "")
            }

            
        }
        
    }

    //LOGIN WITH GOOGLE
    func loginWithGoogle(completionHandler: @escaping ((GameUser?)->Void)) {
        MBProgressHUD.showAdded(to: self.viewController.view, animated: true)
        let signInConfig = GIDConfiguration.init(clientID: Constant.GOOGLE_CLIENT_ID)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self.viewController) { authUser, error in
            if let error = error {
                MBProgressHUD.hide(for: self.viewController.view, animated: true)
                self.viewController.showSimpleAlert(title: "Danetkas", message: error.localizedDescription)
                completionHandler(nil)
                return
            } else {
                var user = GameUser()
                user.email = authUser?.profile?.email
                user.name = authUser?.profile?.name
                user.userType = "social"
                completionHandler(user)
            }
        }
        
    }
    
    func loginWithFacebook(completionHandler: @escaping ((LoginManagerLoginResult?)->Void)) {
        
        MBProgressHUD.showAdded(to: self.viewController.view, animated: true)
        let loginManager = LoginManager()
        loginManager.logIn(permissions: Constant.facebookLoginPermissions, from: self.viewController) { loginResult, error in

            
            if let error = error {
                MBProgressHUD.hide(for: self.viewController.view, animated: true)
                self.viewController.showSimpleAlert(title: "Danetkas", message: error.localizedDescription)
                completionHandler(nil)
                return
            }
            
            
            completionHandler(loginResult)
            
//            if let token = AccessToken.current?.tokenString {
//                print(token)
//                let credentials = FacebookAuthProvider.credential(withAccessToken: token)
//                Auth.auth().signIn(with: credentials) { result, error in
//                    
//                    if let error = error {
//
//                        MBProgressHUD.hide(for: self.viewController.view, animated: true)
//                        self.viewController.showSimpleAlert(title: "Danetkas", message: error.localizedDescription)
//                        return
//                    }
//
//                    //LOGIN
//                }
//            }
        }
    }
    
    func loginUser(parameters: Parameters, completionHandler: @escaping loginCompletion) {
        
        HTTPService.shared.postRequestWithoutHeader(endpoint: Endpoint.login, parameters: parameters, model: GameUser.self) { response, error in
            
            guard response != nil else {
                completionHandler(nil,error)
                return
            }
            
            if response?.code == 200 {
                
                self.loginUser = response?.data
                completionHandler(self.loginUser,nil)
                
            } else {
                completionHandler(nil,error)
            }
        }
    }
}


