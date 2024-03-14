//
//  MovieViewModel.swift
//  HopeMovie
//
//  Created by Umut Erol on 12.02.2024.
//

import Foundation
import UIKit
import RxSwift




class MovieViewModel {
    
    let movieList : PublishSubject<[Results]> = PublishSubject()
    var movies = [Results]()
    let error : PublishSubject<String> = PublishSubject()
    let loading : PublishSubject<Bool> = PublishSubject()
    
    
    func requestData(movieCategoryStringRequest : String = "popular") {
        
    
        
        self.loading.onNext(true)
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieCategoryStringRequest)?api_key=3e4dbb0176e7f36f4df0a3b954f5a609")
        
        WebServices.shared.downloadMovie(url: url!) { results in
            self.loading.onNext(false)

            switch results {
            case .failure(let error):
                switch error{
                case .servicesError:
                    self.error.onNext("Services Error!")
                case .parseError:
                    self.error.onNext("Parsing Error!")
                }
            case .success(let movieList):
                self.movieList.onNext(movieList!)
                self.movies = movieList!
                for liste in self.movies{
                    print(liste.title)
                }
            }
            
        }
    }
}
