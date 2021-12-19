//
//  Pagination.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 05/11/2021.
//

import Foundation


struct Pagination: Codable {

    var page: Int?
    var count: Int?
    var pages: Int?
    var sortBy: String?
    var sortOrder: String?
    
    private enum CodingKeys: String,CodingKey {
        case page
        case count
        case pages
        case sortBy
        case sortOrder
    }
    
    init(page: Int? = nil, count: Int? = nil, pages: Int? = nil, sortBy: String? = nil, sortOrder: String? = nil) {
        self.page = page
        self.count = count
        self.pages = pages
        self.sortBy = sortBy
        self.sortOrder = sortOrder
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sortBy = try container.decode(String.self, forKey: .sortBy)
        sortOrder = try container.decode(String.self, forKey: .sortOrder)
        
        do {
            page = try container.decode(Int.self, forKey: .page)
            count = try container.decode(Int.self, forKey: .count)
            pages = try container.decode(Int.self, forKey: .pages)
        } catch DecodingError.typeMismatch{
            pages = try Int(container.decode(String.self, forKey: .pages))
            count = try Int(container.decode(String.self, forKey: .count))
            pages = try Int(container.decode(String.self, forKey: .pages))
        }
    }
    
}

