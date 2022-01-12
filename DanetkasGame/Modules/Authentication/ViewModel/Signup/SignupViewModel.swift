//
//  SignupViewModel.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 04/11/2021.
//

import UIKit
import MBProgressHUD
import GoogleSignIn
import FBSDKLoginKit
//import LegacyCoreKit

class SignupViewModel {
    
    typealias registrationCompletion = ((RegisterDataResponse?,String?)->Void)
    
    private var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    var registeredUser: RegisterDataResponse?
    
    func registerUser(parameters: Parameters,completionHandler: @escaping registrationCompletion) {
        
        
        MBProgressHUD.showAdded(to: self.viewController.view, animated: true)
        HTTPService.shared.postRequestWithoutHeader(endpoint: Endpoint.register, parameters: parameters, model: RegisterDataResponse.self) { response, error in
            guard response != nil else {
                MBProgressHUD.hide(for: self.viewController.view, animated: true)
                completionHandler(nil,error?.localizedDescription ?? "")
                return
            }
            
            if response?.code == 201 {
                MBProgressHUD.hide(for: self.viewController.view, animated: true)
                self.registeredUser = response?.data
                Endpoint.authToken = self.registeredUser?.user?.accessToken
                Utility.shared.user = self.registeredUser?.user
                completionHandler(self.registeredUser,nil)
                
            } else if response?.code == 208 {
                MBProgressHUD.hide(for: self.viewController.view, animated: true)
                completionHandler(nil,response?.message ?? "")
            } else {
                MBProgressHUD.hide(for: self.viewController.view, animated: true)
                completionHandler(nil,response?.message ?? "")
            }

            
        }
        
    }
    


    //LOGIN WITH GOOGLE
    func loginWithGoogle(completionHandler: @escaping registrationCompletion) {
        MBProgressHUD.showAdded(to: self.viewController.view, animated: true)
        let signInConfig = GIDConfiguration.init(clientID: Constant.GOOGLE_CLIENT_ID)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self.viewController) { authUser, error in
            if let error = error {
                MBProgressHUD.hide(for: self.viewController.view, animated: true)
                //self.viewController.showSimpleAlert(title: "Danetkas", message: error.localizedDescription)
                completionHandler(nil,error.localizedDescription)
                return
            } else {
                var user = GameUser()
                user.email = authUser?.profile?.email
                user.name = authUser?.profile?.name
                user.userType = "social"
                
                let params = ["email": user.email ?? "",
                              "userType": "social"]
                
                self.registerUser(parameters: params, completionHandler: completionHandler)
                
            }
        }
        
    }
    
    
    //LOGIN WITH FACEBOOK
    func loginWithFacebook(completionHandler: @escaping registrationCompletion) {
        
        MBProgressHUD.showAdded(to: self.viewController.view, animated: true)
        let loginManager = LoginManager()
        loginManager.logIn(permissions: Constant.facebookLoginPermissions, from: self.viewController) { loginResult, error in

            
            if let error = error {
                MBProgressHUD.hide(for: self.viewController.view, animated: true)
                self.viewController.showSimpleAlert(title: "Danetkas", message: error.localizedDescription)
                completionHandler(nil,error.localizedDescription)
                return
            }
            if AccessToken.isCurrentAccessTokenActive {
                
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email , gender"]).start { connection, result, error in
                    if error == nil {
                        
                        let dictionay = result as? [String: Any]
                        let name = dictionay!["name"] as! String
                        let email = dictionay!["email"] as! String
                        var user = GameUser()
                        user.email = email
                        user.name = name
                        user.userType = "social"
                        
                        let params = ["email": user.email ?? "",
                                      "userType": "social"]
                        
                        self.registerUser(parameters: params, completionHandler: completionHandler)
                    }
                }
            }
            
        }
    }
    
    
}


struct RegisterDataResponse: Codable {
    var user: GameUser?
}
