//
//  Danetka.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 05/11/2021.
//

import Foundation

protocol Danetka: Codable {
    var id: Int? {get set}
    var name: String? {get set}
    var image: String? {get set}
    var paymentStatus: String? {get set}
    var status: Bool? {get set}
    var updatedTime: Int? {get set}
}

//struct Danetka: Codable {
//    var id: Int?
//    var name: String?
//    var image: String?
//    var paymentStatus: String?
//    var status: Bool?
//    var updatedTime: Int?
//}
