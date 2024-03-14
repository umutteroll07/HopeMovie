//
//  MovieModel.swift
//  HopeMovie
//
//  Created by Umut Erol on 10.02.2024.
//

import Foundation

struct MovieModel: Codable {
    let results: [Results]
}

struct Results: Codable {
    let id : Int
    let backdrop_path : String
    let title : String
    let vote_average: Double
    let overview : String
    let poster_path : String
    let release_date : String
}
