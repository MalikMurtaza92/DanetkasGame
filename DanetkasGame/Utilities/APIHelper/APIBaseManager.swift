//
//  APIHelper.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 02/11/2021.
//

import Foundation
import Alamofire

struct ResponseError{
    var title: String
    var description: String
}

class HTTPService{
    
    typealias completionHandler = (Data?,Error?)->Void
    typealias responseHandler<T: Codable> = (APIResponse<T>?,Error?)-> Void
    
    private var alamofire: Session!
    
    static let shared = HTTPService()
    
    
    init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        alamofire = Session(configuration:configuration)
    }
    
    
    fileprivate func fetchRequest(endpoint:URL,parameters: Parameters?,header: HTTPHeaders?,completionHandler: @escaping completionHandler) {
        alamofire.request(endpoint,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: header).responseJSON { response in
                            
                            print("************GET************")
                            print(endpoint.absoluteString)
                            print("HEADER: \(String(describing: header ?? HTTPHeaders()))")
                            switch response.result{
                            
                            case .success(_):
                                if response.error == nil {
                                    print("---SUCCESS---")
                                    print(response.value)
                                    completionHandler(response.data,nil)
                                } else {
                                    print("---SUCCESS-ERROR---")
                                    print(response.error)
                                    print("ERROR CODE: \(response.error?.responseCode)")
                                    completionHandler(nil,response.error)
                                    completionHandler(response.data,nil)
                                }
                                
                                break
                            case .failure(let error):
                                print("---FAILURE---")
                                print(error)
                                print("ERROR CODE: \(String(describing: error.responseCode))")
                                completionHandler(nil,error)
                                break
                            }
                            print("*************GET-END**************")
                            
        }
    }
    
    
    fileprivate func postRequest(endpoint:URL, parameters: Parameters?,header: HTTPHeaders?,completionHandler: @escaping completionHandler) {
        
        alamofire.request(endpoint,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: header).responseJSON { response in
            
                            print("************POST************")
                            print(endpoint.absoluteString)
                            print("HEADER: \(String(describing: header))")
                            print("BODY: \(String(describing: parameters))")
                            switch response.result{
                            
                            case .success(_):
                                if response.error == nil {
                                    print("---SUCCESS---")
                                    print(response.value)
                                    completionHandler(response.data,nil)
                                } else {
                                    print("---SUCCESS-ERROR---")
                                    print(response.error)
                                    print("ERROR CODE: \(response.error?.responseCode)")
                                    completionHandler(nil,response.error)
                                    completionHandler(response.data,nil)
                                }
                                
                                break
                            case .failure(let error):
                                print("---FAILURE---")
                                print(error)
                                print("ERROR CODE: \(error.responseCode)")
                                completionHandler(nil,error)
                                break
                            }
                            print("*************POST-END**************")
                            
        }
    }
    
    func postRequestWithMultipart(endpoint:URL, parameters: Parameters,header: HTTPHeaders?,images: [UIImage],completionHandler: @escaping completionHandler) {
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in parameters {
                multipartFormData.append((value).data(using: String.Encoding.utf8)!, withName: key)
            }
            
            for img in images {
                guard let imgData = img.jpegData(compressionQuality: 1) else { return }
                multipartFormData.append(imgData, withName: "image", fileName: DanetkasHelper.generateCurrentTimeStamp() + ".jpeg", mimeType: "image/jpeg")
            }
        },to: endpoint, usingThreshold: UInt64.init(),
          method: .post,
          headers: header).response{ response in
            print("************POST-MULTIPART************")
            print(endpoint.absoluteString)
            print("HEADER: \(String(describing: header))")
            print("BODY: \(String(describing: parameters))")
            switch response.result{
            
            case .success(_):
                if response.error == nil {
                    print("---SUCCESS---")
                    print(response.value)
                    completionHandler(response.data,nil)
                } else {
                    print("---SUCCESS-ERROR---")
                    print(response.error)
                    print("ERROR CODE: \(response.error?.responseCode)")
                    completionHandler(nil,response.error)
                    completionHandler(response.data,nil)
                }
                
                break
            case .failure(let error):
                print("---FAILURE---")
                print(error)
                print("ERROR CODE: \(error.responseCode)")
                completionHandler(nil,error)
                break
            }
            print("*************POST-MULTIPART-END**************")
        }
    }
    
    fileprivate func decodeResponse<T: Codable>(data: Data?, error: Error,model: T.Type,completionHandler: @escaping responseHandler<T>) {
        if data != nil {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(APIResponse<T>.self, from: data!)
                completionHandler(model,nil)
            } catch let error {
                print("*************DECODING-ERROR**************")
                print(error)
                completionHandler(nil,error as Error)
            }
        } else {
            completionHandler(nil,error)
        }
    }
    
    
    func postRequestWithoutHeader<T: Codable>(endpoint: URL, parameters: Parameters? = nil,model: T.Type ,completionHandler: @escaping responseHandler<T>) {
        self.postRequest(endpoint: endpoint, parameters: parameters, header: nil) { data, error in
            if data != nil {
                let decoder = JSONDecoder()
                do {
                    let model = try decoder.decode(APIResponse<T>.self, from: data!)
                    completionHandler(model,nil)
                } catch let error {
                    print("*************DECODING-ERROR**************")
                    print(error)
                    completionHandler(nil,error as Error)
                }
            } else {
                completionHandler(nil,error)
            }
        }
    }
    
    func postRequestWithHeader<T: Codable>(endpoint: URL, parameters: Parameters? = nil,header: HTTPHeaders = Endpoint.headers,model: T.Type ,completionHandler: @escaping responseHandler<T>) {
        self.postRequest(endpoint: endpoint, parameters: parameters, header: header) { data, error in
            if data != nil {
                let decoder = JSONDecoder()
                do {
                    let model = try decoder.decode(APIResponse<T>.self, from: data!)
                    completionHandler(model,nil)
                } catch let error {
                    print("*************DECODING-ERROR**************")
                    print(error)
                    completionHandler(nil,error as Error)
                }
            } else {
                completionHandler(nil,error)
            }
        }
    }
    
    func getRequestWithOutHeader<T: Codable>(endpoint: URL,parameters: Parameters? = nil,model: T.Type,completionHandler: @escaping responseHandler<T>){
        self.fetchRequest(endpoint: endpoint, parameters: parameters, header: nil) { data, error in
            if data != nil {
                let decoder = JSONDecoder()
                do {
                    let model = try decoder.decode(APIResponse<T>.self, from: data!)
                    completionHandler(model,nil)
                } catch let error {
                    print("*************DECODING-ERROR**************")
                    print(error)
                    completionHandler(nil,error as Error)
                }
            } else {
                completionHandler(nil,error)
            }
        }
    }
    
    func getRequestWithHeader<T: Codable>(endpoint: URL,parameters: Parameters? = nil,header: HTTPHeaders? = nil,model: T.Type,completionHandler: @escaping responseHandler<T>){
        self.fetchRequest(endpoint: endpoint, parameters: parameters, header: header) { data, error in
            if data != nil {
                let decoder = JSONDecoder()
                do {
                    let model = try decoder.decode(APIResponse<T>.self, from: data!)
                    completionHandler(model,nil)
                } catch let error {
                    print("*************DECODING-ERROR**************")
                    print(error)
                    completionHandler(nil,error as Error)
                }
            } else {
                completionHandler(nil,error)
            }
        }
    }
    
    
}
