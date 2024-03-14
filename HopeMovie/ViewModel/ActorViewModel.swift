//
//  ActorViewModel.swift
//  HopeMovie
//
//  Created by Umut Erol on 19.02.2024.
//

import Foundation
import UIKit
import RxSwift


class ActorMovieModel{
    
    let actorList : PublishSubject<[ActorResults]> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    
    func requestActorData(id : Int) {
        
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=3e4dbb0176e7f36f4df0a3b954f5a609")
        
        
        WebServices.shared.downloadActor(url: url!) { actorResults in
            switch actorResults {
            case .failure(let error):
                switch error {
                case .servicesError:
                    self.error.onNext("Services Error")
                case .parseError:
                    self.error.onNext("Parsing Error")
                }
            case .success(let actorList):
                self.actorList.onNext(actorList!)
                
            }
        }
    }
    
    
}
