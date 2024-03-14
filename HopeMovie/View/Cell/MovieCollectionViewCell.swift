//
//  MovieCollectionViewCell.swift
//  HopeMovie
//
//  Created by Umut Erol on 12.02.2024.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var lbl_movieTitle: UILabel!
    @IBOutlet weak var lbl_movieIMDB: UILabel!
    @IBOutlet weak var image_favMovie: UIImageView!
    
    
    


    public var item : Results! {
        
        didSet {
            let imdb = String(format: "%.1f", item.vote_average)
            self.lbl_movieTitle.text = item.title
            self.lbl_movieIMDB.text = imdb
            self.movieImage.image = UIImage.checkmark
            
            let imageUrlString = "https://image.tmdb.org/t/p/w500\(item.poster_path ?? "")"
            if let imageUrl = URL(string: imageUrlString), let imageData = try? Data(contentsOf: imageUrl) {
                let image = UIImage(data: imageData)
                self.movieImage.image = image
            }
            
            
            
        }
        
    
        
    }
    
    
    
}
