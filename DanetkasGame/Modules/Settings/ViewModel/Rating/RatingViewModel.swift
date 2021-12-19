//
//  RatingViewModel.swift
//  DanetkasGameApp
//
//  Created by Murtaza Mehmood on 29/08/2021.
//

import Foundation

struct RatingViewModel {
    var ratings: [RatingsModel] = []
    
    init(){
        ratings = [RatingsModel(question: "How hard was this Danetka?", rating: 2.0),
                   RatingsModel(question: "Did you enjoy it?", rating: 2.0),
                   RatingsModel(question: "Were the rigolettos helpful?", rating: 2.0),
                   RatingsModel(question: "How hard was this Danetka?", rating: 2.0)]
    }
}

struct RatingsModel {
    var question: String
    var rating: Double
}
