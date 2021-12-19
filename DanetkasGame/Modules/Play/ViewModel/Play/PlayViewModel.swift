//
//  PlayViewModel.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 05/11/2021.
//

import Foundation


class PlayViewModel {
    
    typealias playCompletion = ((DanetkasData?,Error?)->Void)
    
    var danetkas: [DanetkaModel]?
    var myDanetkasPagination: Pagination?
    
    var moreDanetkas: [DanetkaModel]?
    var moreDanetkasPagination: Pagination?
    
    init() {
        //self.danetkas = []
        myDanetkasPagination = Pagination()
    }
    
    func fetchMyDanetkas(completionHandler: @escaping playCompletion) {
        HTTPService.shared.getRequestWithHeader(endpoint: Endpoint.myDanetka,header: (Endpoint.authToken != nil) ? Endpoint.headers : nil ,model: DanetkasData.self) { response, error in
            guard response != nil else {
                completionHandler(nil,error)
                return
            }
            
            if response?.code == 200 {
                self.danetkas = response?.data?.listing
                self.myDanetkasPagination =  response?.data?.pagination
                completionHandler(response?.data, nil)
                
            } else {
                completionHandler(nil,error)
            }
        }
    }
    
    func fetchMoreDanetkas(completionHandler: @escaping playCompletion) {
        
        HTTPService.shared.getRequestWithOutHeader(endpoint: Endpoint.moreDanetka, model: DanetkasData.self) { response, error in
            guard response != nil else {
                completionHandler(nil,error)
                return
            }
            
            if response?.code == 200 {
                self.moreDanetkas = response?.data?.listing
                self.moreDanetkasPagination =  response?.data?.pagination
                completionHandler(response?.data, nil)
                
            } else {
                completionHandler(nil,error)
            }
        }
    }
    
    
    
    
    struct DanetkasData: Codable {
        var listing: [DanetkaModel]?
        var pagination: Pagination?
    }
    
    
    struct DanetkaModel: Danetka {
        var id: Int?
        var name: String?
        var image: String?
        var paymentStatus: String?
        var status: Bool?
        var updatedTime: Int?
    }
    
}
