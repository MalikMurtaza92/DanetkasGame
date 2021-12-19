//
//  DanetkasViewModel.swift
//  DanetkasGame
//
//  Created by Murtaza Mehmood on 13/12/2021.
//

import Foundation


class DanetkasViewModel {
    
    typealias fetchDanetkasCompletion = (DanetkasData?, String?)->Void
    var page: Int = 0
    var danetkaListing: [DanetkaListing]?
    
    init() {
        danetkaListing = []
    }
    
    func fetchDanetkas(completion: @escaping fetchDanetkasCompletion) {
        
        HTTPService.shared.getRequestWithHeader(endpoint: Endpoint.allDanetkas,parameters: ["page":"\(page)"],model: DanetkasData.self) { response, error in
            if error == nil {
                if response?.code  == 200 {
                    completion(response?.data,nil)
                } else {
                    completion(nil,response?.message ?? "")
                }
            } else {
                completion(nil,error?.localizedDescription)
            }
        }
    }
    
    
    struct DanetkasData: Codable {
        var listing: [DanetkaListing]?
        //var pagination: Pagination?
    }
    
    
    struct DanetkaListing: Danetka {
        var id: Int?
        var name: String?
        var hint: String?
        var image: String?
        var paymentStatus: String?
        var status: Bool?
        var updatedTime: Int?
    }
    
}
