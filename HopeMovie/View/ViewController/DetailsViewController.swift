//
//  DetailsViewController.swift
//  HopeMovie
//
//  Created by Umut Erol on 15.02.2024.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseFirestore
import FirebaseAuth

class DetailsViewController: UIViewController, UIScrollViewDelegate {
    
    
    let actorViewModel = ActorMovieModel()
    let disposeBag = DisposeBag()
    var id = Int()
    
    var selectedTitle = String()
    var selectedImageUrl = String()
    var selectedOverView = String()
    var selectedDate = String()
    var selectedID = Int()
    var controlOfSelected = false
    
    var getQueryMovie = [Results]()
    
    @IBOutlet weak var image_movie: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_descreption: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var actorCollectionView: UICollectionView!
    @IBOutlet weak var btn_favourite: UIButton!
    
    var results: Results?
    
    // Firestore veritabanı referansını al
    let firestoreDatabase = Firestore.firestore()
    var currentUserId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_title.text = results?.title
        lbl_descreption.text = results?.overview
        lbl_date.text = results?.release_date
        
        
        if controlOfSelected == false {
            id = Int(results!.id)
        }
      
       
        fav_btn_fill_or_empty()
        
        
        if self.controlOfSelected {
            self.lbl_title.text = selectedTitle
            self.lbl_descreption.text = selectedOverView
            self.lbl_date.text = selectedDate
            
            
            self.actorCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
            setupBinding()
            actorViewModel.requestActorData(id: self.selectedID)
            actorCollectionView.reloadData()
            
            
            let imageUrlString = "https://image.tmdb.org/t/p/w500\(self.selectedImageUrl ?? "")"
            if let imageUrl = URL(string: imageUrlString), let imageData = try? Data(contentsOf: imageUrl) {
                let image = UIImage(data: imageData)
                self.image_movie.image = image
            }
            
            controlOfSelected = false
            
        }
        
        
        let userF = Auth.auth().currentUser
        currentUserId = userF?.uid as? String ?? ""
        
        let imageUrlString = "https://image.tmdb.org/t/p/w500\(results?.poster_path ?? "")"
        if let imageUrl = URL(string: imageUrlString), let imageData = try? Data(contentsOf: imageUrl) {
            let image = UIImage(data: imageData)
            self.image_movie.image = image
            
            
            
            self.actorCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
            setupBinding()
            actorViewModel.requestActorData(id: id)
            actorCollectionView.reloadData()
            
            
        }
        
        
    }
    
    private func setupBinding() {
        
        actorViewModel
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        
        
        actorViewModel
            .actorList
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: self.actorCollectionView.rx.items(cellIdentifier: "actorInfoCell",cellType: ActorCollectionViewCell.self)) { row,item,cell in
                cell.item = item
            }
            .disposed(by: disposeBag)
        
    }

    @IBAction func clicked_fav(_ sender: Any) {
        
        guard let user = Auth.auth().currentUser else { return }
        currentUserId = user.uid
        
        if self.btn_favourite.tag == 0 {
            btn_favourite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            btn_favourite.tag = 1
            
            

            guard let results = results else {
                return
            }
            let firestoreFavourites = ["imageUrl": results.poster_path, "title" : results.title,"overview":results.overview,"date":results.release_date,"id":results.id,"userId":currentUserId] as [String:Any]
            firestoreDatabase.collection("favoriteMovie").addDocument(data: firestoreFavourites) { error in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    print("başarılı kayıt")
                }
            }
        }
        else if btn_favourite.tag == 1 {
            btn_favourite.setImage(UIImage(systemName: "heart"), for: .normal)
            btn_favourite.tag = 0
            
        }
        
    }
    
    @IBAction func clicked_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func fav_btn_fill_or_empty() {
        
        let favVC = self.storyboard?.instantiateViewController(identifier: "toFavoriteVC") as? FavouritesViewController
                
        if let favVC = favVC {
//            if favVC.idArray.contains(self.id) {
//                btn_favourite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//            } else {
//                btn_favourite.setImage(UIImage(systemName: "heart"), for: .normal)
//            }
         
        }

        
        
    }

}
