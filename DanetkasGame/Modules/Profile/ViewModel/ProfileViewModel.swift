//
//  ProfileViewModel.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 05/11/2021.
//

import UIKit


class ProfileViewModel {
    
    typealias profileCompletion = ((GameUser?,Error?)->Void)
    
    
    private var viewController: UIViewController
    
    var user: GameUser?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func setupUserProfile(parameters: Parameters,completionHandler: @escaping profileCompletion) {
        
        HTTPService.shared.postRequestWithHeader(endpoint: Endpoint.profile, parameters: parameters,model: GameUser.self) { response, error in
            
            guard response != nil else {
                completionHandler(nil,error)
                return
            }
            
            if response?.code == 200 {
                
                self.user = response?.data
                Endpoint.authToken = self.user?.accessToken
                Utility.shared.user = self.user
                completionHandler(self.user,nil)
                
            } else {
                completionHandler(nil,error)
            }
        }
    }
    
}
