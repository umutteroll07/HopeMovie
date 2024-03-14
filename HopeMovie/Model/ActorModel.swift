//
//  ActorModel.swift
//  HopeMovie
//
//  Created by Umut Erol on 19.02.2024.
//

import Foundation


struct ActorModel : Codable {
    let cast : [ActorResults]
}


struct ActorResults : Codable {
    let id : Int
    let name : String
    let character : String
    let profile_path : String?
}
