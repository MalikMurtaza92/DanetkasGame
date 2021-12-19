//
//  DanetkasHelper.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 21/08/2021.
//

import UIKit


struct DanetkasHelper{
    
    static func getViewController(storyboard: Storyboards,identifier: StoryboardIdentifiers) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let VC = storyboard.instantiateViewController(identifier: identifier.rawValue)
        return VC
    }
    
}
