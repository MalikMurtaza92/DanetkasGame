//
//  PlayViewModel.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 05/11/2021.
//

import Foundation
import UIKit
import Alamofire


class PlayViewModel {
    
    typealias playCompletion = ((DanetkasData?,Error?)->Void)
    
    var danetkas: [DanetkaModel]?
    var myDanetkasPagination: Pagination?
    
    var loginDantkas: [LoginDanetkaModel]?
    
    var moreDanetkas: [DanetkaModel]?
    var moreDanetkasPagination: Pagination?
    
    init() {
        //self.danetkas = []
        myDanetkasPagination = Pagination()
    }
    
    func fetchLoginMyDanetkas(completionHandler: @escaping ((LoginDanetkaData?,Error?)->Void)) {
        HTTPService.shared.getRequestWithHeader(endpoint: Endpoint.myDanetka,header: (Endpoint.authToken != nil) ? Endpoint.headers : nil ,model: LoginDanetkaData.self) { response, error in
            
            guard response != nil else {
                completionHandler(nil,error)
                return
            }
            
            if response?.code == 200 {
                self.loginDantkas = response?.data?.listing
                self.myDanetkasPagination =  response?.data?.pagination
                completionHandler(response?.data, nil)
                
            } else {
                completionHandler(nil,error)
            }
        }
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
    
    
    func makeMyDanetka(parameter: Parameters,images:[UIImage]) {
        let header: HTTPHeaders = ["Authorization":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODcsImVtYWlsIjoibXVydGF6YW1laG1vb2QxOTkyQGdtYWlsLmNvbSIsImlhdCI6MTY0MDQ0NDAzMywiZXhwIjoxNjcxOTgwMDMzfQ.KpU6psdDe7Eb8VPqI5xA7cUNBjKqhyser_nUqonKndA"]
        HTTPService.shared.postRequestWithMultipart(endpoint: Endpoint.makeDanetkas, parameters: parameter, header: Endpoint.headers, images: images){ response, error in
            print(String(data: response!, encoding: .utf8))
        }
    }
    
    
    struct DanetkasData: Codable {
        var listing: [DanetkaModel]?
        var pagination: Pagination?
    }
    
    
    struct DanetkaModel: Danetka {
        var answer: String?
        var hint: String?
        var id: Int?
        var title: String?
        var image: String?
        var paymentStatus: String?
        var status: Bool?
        var updatedTime: Int?
        var question: String?
        var learnMore: String?
    }
    
    struct LoginDanetkaData: Codable {
        var listing: [LoginDanetkaModel]?
        var pagination: Pagination?
    }
    
    struct LoginDanetkaModel: Codable {
        var id: Int?
        var status: Bool?
        var danetkas: DanetkaModel?
    }
}
