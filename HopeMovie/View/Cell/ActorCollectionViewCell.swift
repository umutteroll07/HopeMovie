//
//  ActorCollectionViewCell.swift
//  HopeMovie
//
//  Created by Umut Erol on 19.02.2024.
//

import UIKit

class ActorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image_actorProfile: UIImageView!
    @IBOutlet weak var lbl_actorName: UILabel!
    
    
    
    public var item : ActorResults! {
        didSet{
            
            lbl_actorName.text = item.name
            let imageUrlString = "https://image.tmdb.org/t/p/w500\(item.profile_path ?? "")"
            if let imageUrl = URL(string: imageUrlString), let imageData = try? Data(contentsOf: imageUrl) {
                let image = UIImage(data: imageData)
                self.image_actorProfile.image = image
            }
            
        }
        
    }
    
}
