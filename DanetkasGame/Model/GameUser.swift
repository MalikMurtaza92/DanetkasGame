//
//  User.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 04/11/2021.
//

import Foundation

struct GameUser: Codable {
    var id: Int?
    var name: String?
    var userName: String?
    var dateOfBirth: String?
    var gender: String?
    var nationality: String?
    var language: String?
    var email: String?
    var accessToken: String?
    var userType: String?
    var isProfileSet: Bool?
    var status: Bool?
    var updatedTime: Int?
}
