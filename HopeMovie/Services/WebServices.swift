//
//  WebServices.swift
//  HopeMovie
//
//  Created by Umut Erol on 10.02.2024.
//

import Foundation
import UIKit


enum MovieWebServicesError : Error {
    case servicesError
    case parseError
}

class WebServices {
  
    static let shared = WebServices()
    
    
    func downloadMovie (url : URL , complationHandler : @escaping( Result<[Results]?,MovieWebServicesError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                complationHandler(.failure(.servicesError))
                
            }
            else if let data = data {
                let movieList = try? JSONDecoder().decode(MovieModel.self, from: data)
                if let movieList = movieList {
                    complationHandler(.success(movieList.results))
                }
                else {
                    complationHandler(.failure(.parseError))
                }
            }
            else {
            }
            
        }.resume()
        
    }
    
    
    
    func downloadActor (url : URL , complationHandler : @escaping(Result<[ActorResults]?,MovieWebServicesError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) {data,response,error in
            if error != nil {
                complationHandler(.failure(.servicesError))
            }
            else if let data = data {
                let actorList = try? JSONDecoder().decode(ActorModel.self, from: data)
                if let actorList = actorList {
                    complationHandler(.success(actorList.cast))
                }
                else {
                    complationHandler(.failure(.parseError))
                }
            }
            else {
            }
            
        }.resume()
    }
    
    
}
