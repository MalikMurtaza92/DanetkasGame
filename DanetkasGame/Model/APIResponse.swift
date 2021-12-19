//
//  APIResponse.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 04/11/2021.
//

import Foundation


struct APIResponse<T: Codable>: Codable {
    var code: Int?
    var data: T?
    var status: String?
    var message: String?
}
