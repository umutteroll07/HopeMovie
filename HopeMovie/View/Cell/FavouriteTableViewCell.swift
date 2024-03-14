//
//  FavouriteTableViewCell.swift
//  HopeMovie
//
//  Created by Umut Erol on 19.02.2024.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    
    
  
    
    @IBOutlet weak var imageView_fav_movie: UIImageView!
    @IBOutlet weak var lbl_fav_movie: UILabel!
    @IBOutlet weak var view_favMovieBackground: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        

    }

}
