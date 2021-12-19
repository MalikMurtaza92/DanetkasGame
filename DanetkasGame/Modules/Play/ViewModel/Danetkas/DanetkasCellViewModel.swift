//
//  DanetkasCellViewModel.swift
//  DanetkasGame
//
//  Created by Murtaza Mehmood on 13/12/2021.
//

import Foundation

class DanetkasCellViewModel {
    var Danetkas: DanetkasViewModel.DanetkaListing?
    var indexPath: IndexPath?
    
    init(danetka: DanetkasViewModel.DanetkaListing?, indexPath: IndexPath){
        self.Danetkas = danetka
        self.indexPath = indexPath
    }
}
