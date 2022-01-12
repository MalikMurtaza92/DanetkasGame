//
//  File.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 04/11/2021.
//

import Foundation

class Utility: NSObject {
    
    static let shared = Utility()
    
    var isInvestigator: Bool?
    var isMaster: Bool?
    var isPlayAsGuest: Bool? {
        set {
            UserDefaults.standard.set(newValue, forKey: "isPlayAsGuest")
        } get {
            UserDefaults.standard.value(forKey: "isPlayAsGuest") as? Bool
        }
    }
    var showRuleViewAgain: Bool = true
    
    var playRulePopUp: Bool? {
        set {
            UserDefaults.standard.set(newValue, forKey: "playRulePopUp")
        } get {
            UserDefaults.standard.value(forKey: "playRulePopUp") as? Bool
        }
    }
    
    var user: GameUser? {
        get {
            if let data = UserDefaults.standard.value(forKey: "user") as? Data{
                return try? JSONDecoder().decode(GameUser.self, from: data)
            } else {
                return nil
            }
            
        } set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "user")
            }
        }
    }
}
